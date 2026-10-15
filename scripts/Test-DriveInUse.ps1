<#
.SYNOPSIS
  Shows what keeps a drive busy, and proves whether nothing has it open any more.

.DESCRIPTION
  Run in an elevated PowerShell (Run as administrator). Read-only, apart from a lock on the
  volume that is held for a fraction of a second and released at once.

  1. Processes started from the drive, or with a DLL loaded from it (Steam, games, launchers).
  2. Services whose program lives on the drive (they restart by themselves; stop or disable them).
  3. A page file on the drive (needs a reboot to move away).
  4. Open files per process, if Sysinternals handle64.exe is next to this script or on PATH.
  5. The verdict: Windows is asked for an exclusive lock on the volume. That lock is only granted
     when no process has any file, folder or the volume itself open: exactly the condition for
     safely copying the drive and deleting the old partition.

  Exit code 0 = drive free, 1 = drive in use.

.EXAMPLE
  .\Test-DriveInUse.ps1 -DriveLetter D
#>
param([ValidatePattern('^[A-Za-z]$')][string]$DriveLetter = 'D')

$ErrorActionPreference = 'Stop'
$root = "$($DriveLetter.ToUpper()):\"
$busy = $false

Write-Host "== 1. Processes running from $root"
$procs = foreach ($p in Get-Process) {
    $hits = @()
    if ($p.Path -like "$root*") { $hits += $p.Path }
    try { $hits += $p.Modules | Where-Object FileName -like "$root*" | Select-Object -ExpandProperty FileName } catch { }
    if ($hits) { [pscustomobject]@{ Process = $p.ProcessName; PID = $p.Id; Example = ($hits | Select-Object -First 1); Files = ($hits | Sort-Object -Unique).Count } }
}
if ($procs) { $busy = $true; $procs | Sort-Object Process | Format-Table -AutoSize | Out-String -Width 200 | Write-Host } else { Write-Host '   none' }

Write-Host "== 2. Services with their program on $root"
$svcs = Get-CimInstance Win32_Service | Where-Object { $_.PathName -match "^`"?$DriveLetter`:\\" }
if ($svcs) { $svcs | Format-Table Name, State, StartMode, PathName -AutoSize | Out-String -Width 200 | Write-Host } else { Write-Host '   none' }

Write-Host "== 3. Page file on $root"
$pf = Get-CimInstance Win32_PageFileUsage | Where-Object Name -like "$root*"
if ($pf) { $busy = $true; Write-Host "   $($pf.Name): move it in System Properties > Advanced > Performance > Virtual memory, then reboot" } else { Write-Host '   none' }

Write-Host "== 4. Open files (Sysinternals handle64.exe)"
$h = @(Join-Path $PSScriptRoot 'handle64.exe'; (Get-Command handle64.exe -ErrorAction SilentlyContinue).Source) | Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1
if ($h) {
    $out = & $h -accepteula -nobanner $root 2>$null | Where-Object { $_ -match 'pid:' }
    if ($out) {
        $busy = $true
        $out | ForEach-Object { if ($_ -match '^(\S+)\s+pid: (\d+)\s+type: \w+\s+\w+: (.+)$') { [pscustomobject]@{ Process = $Matches[1]; PID = [int]$Matches[2]; Path = $Matches[3].Trim() } } } |
            Group-Object Process, PID | ForEach-Object {
                [pscustomobject]@{ Process = $_.Group[0].Process; PID = $_.Group[0].PID; OpenFiles = $_.Count; Example = ($_.Group.Path | Sort-Object -Descending { $_.Length } | Select-Object -First 1) } } |
            Sort-Object Process | Format-Table -AutoSize | Out-String -Width 200 | Write-Host
    } else { Write-Host '   none' }
} else { Write-Host '   skipped (handle64.exe not found; use Resource Monitor > CPU > Associated Handles, search D:\)' }

Write-Host "== 5. Verdict: exclusive lock on volume $root"
Add-Type -Namespace Win32 -Name Vol -MemberDefinition @'
[DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Unicode)]
public static extern Microsoft.Win32.SafeHandles.SafeFileHandle CreateFile(string name, uint access, uint share, IntPtr sa, uint disp, uint flags, IntPtr tmpl);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool DeviceIoControl(Microsoft.Win32.SafeHandles.SafeFileHandle h, uint code, IntPtr inBuf, uint inSize, IntPtr outBuf, uint outSize, out uint ret, IntPtr ov);
'@
$vol = [Win32.Vol]::CreateFile("\\.\$($DriveLetter):", [uint32]3221225472, 3, [IntPtr]::Zero, 3, 0, [IntPtr]::Zero)  # read|write, share read|write, open existing
if ($vol.IsInvalid) { throw "cannot open volume $root (run as administrator): error $([Runtime.InteropServices.Marshal]::GetLastWin32Error())" }
$locked = $false
foreach ($try in 1..3) {   # Defender or the search indexer may hold a file for a moment
    $ret = 0
    if ([Win32.Vol]::DeviceIoControl($vol, 0x90018, [IntPtr]::Zero, 0, [IntPtr]::Zero, 0, [ref]$ret, [IntPtr]::Zero)) { $locked = $true; break }   # FSCTL_LOCK_VOLUME
    $err = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
    Start-Sleep -Seconds 2
}
if ($locked) { [void][Win32.Vol]::DeviceIoControl($vol, 0x9001C, [IntPtr]::Zero, 0, [IntPtr]::Zero, 0, [ref]$ret, [IntPtr]::Zero) }  # FSCTL_UNLOCK_VOLUME
$vol.Close()

if ($locked -and -not $busy) {
    Write-Host "   FREE: nothing has $root open. Safe to copy it and delete the old partition." -ForegroundColor Green
    exit 0
}
if ($locked) { Write-Host "   Lock granted, but see the findings above." -ForegroundColor Yellow; exit 1 }
Write-Host "   IN USE: Windows refused the lock (error $err = $(([ComponentModel.Win32Exception]$err).Message)). Close what is listed above and run again." -ForegroundColor Red
exit 1
