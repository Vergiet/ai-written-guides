# Move Documents, Pictures, Downloads and other personal folders from C: to D: (Windows 11)

Created 2026-10-15. Every step was tested on a real test machine; see [Test evidence](#test-evidence).

This guide is for a PC with one SSD split into a small C: (Windows) and a big D: (data). C: fills up because Windows keeps your Documents, Pictures, Downloads and so on in `C:\Users\<your name>`. The fix is to tell Windows to keep those folders on D: instead. You don't need to know anything about disks. Do the steps in order and compare your screen with the pictures.

**What you'll end up with:** your folders live on D:, everything in Windows and in your programs still finds them in the same place in File Explorer, and C: has room again.

**Time:** about 30 minutes plus copying time. On the test machine 3 to 6 GB took 3 to 4 minutes per folder; folders with many small files take longer.

## Contents

1. [Before you start](#before-you-start)
2. [Part 1: move the standard folders (point and click)](#part-1-move-the-standard-folders)
3. [Part 2: programs that keep their files in AppData](#part-2-programs-that-keep-their-files-in-appdata)
4. [Undo](#undo)
5. [If something goes wrong](#if-something-goes-wrong)
6. [What not to do](#what-not-to-do)
7. [Test evidence](#test-evidence)
8. [Sources](#sources)

## Before you start

1. **Back up.** A second drive in the same PC is not a backup: if the PC dies or is stolen, both go. Copy your important files to an external disk or the cloud first.
2. **Is there room on D:?** Open File Explorer → *This PC*. D: needs more free space than your folders use. Right-click a folder (for example Documents) → *Properties* shows its size.
3. **OneDrive.** If OneDrive backs up your Desktop, Documents or Pictures, those folders are already in `C:\Users\<name>\OneDrive`. Turn that off first: click the OneDrive cloud icon near the clock → gear → *Settings* → *Sync and backup* → *Manage backup* → switch off each folder. If you don't use OneDrive, skip this. (Not tested here.)
4. **Close programs.** Close games, Steam, photo programs, Word, Outlook, and anything else that might have files open in these folders. If you forget one, Windows tells you; see step 7 below.

**Pick one place for everything:** `D:\<your name>\`, for example `D:\Anna\Documents`, `D:\Anna\Pictures`. Use your own name in place of Anna. Each folder gets **its own** subfolder. Never pick `D:\` itself, and never pick a folder that another one already uses (see [What not to do](#what-not-to-do)).

## Part 1: move the standard folders

These folders have a built-in *Location* tab: Desktop, Documents, Downloads, Music, Pictures, Videos, Saved Games. Do them one at a time. Start with Documents; the others go the same way.

**1.** Open File Explorer (the yellow folder on the taskbar). In the left column, right-click **Documents** → **Properties**.

![Right-click Documents, then Properties](images/2026-10-15-move-profile-folders/01-right-click-documents.png)

**2.** Click the **Location** tab. The box shows where Documents is now: `C:\Users\Anna\Documents`.

![The Location tab](images/2026-10-15-move-profile-folders/02-location-tab.png)

**3.** Click in the box, select all text (Ctrl+A) and type the new place: `D:\Anna\Documents`. Click **Apply**. The *Move…* button lets you browse instead, but typing is simpler because Windows makes the folder for you.

![Type the new path, then Apply](images/2026-10-15-move-profile-folders/03-type-new-path.png)

**4.** Windows says the folder doesn't exist yet. Click **Yes** to create it.

![Create Folder: Yes](images/2026-10-15-move-profile-folders/04-create-folder-yes.png)

**5.** Windows asks whether to move all files from the old place to the new one. Check that *Old location* is on C: and *New location* is on D:. Click **Yes**. *No* would only change the place and leave your old files behind on C:.

![Move Folder: Yes](images/2026-10-15-move-profile-folders/05-move-files-yes.png)

**6.** Windows copies the files. Wait until the window closes. Don't switch off the PC.

![Copying in progress](images/2026-10-15-move-profile-folders/06-copying.png)

**7. If a file is in use.** If a program still has a file open, Windows stops and shows *File In Use*. It names the file and the program. In this test it was a game save, `save1.sav`. The test game showed up as "Windows PowerShell"; a real game shows its own name.

![File In Use](images/2026-10-15-move-profile-folders/07-file-in-use.png)

Close that program. If you can't see its window, right-click its icon on the taskbar → **Close window**. For Steam games, also quit Steam: right-click the Steam icon near the clock → *Exit Steam*. Then click **Try Again**. Don't click *Skip*: that leaves the file behind on C:.

![Close the program from the taskbar](images/2026-10-15-move-profile-folders/08-close-game-taskbar.png)

**8.** When copying is done, the box shows `D:\Anna\Documents`. Click **OK**.

![Done: the box shows the D: path](images/2026-10-15-move-profile-folders/09-documents-done.png)

**9.** Repeat steps 1 to 8 for **Pictures, Videos, Music, Downloads and Desktop**, each to its own folder: `D:\Anna\Pictures`, `D:\Anna\Videos`, and so on.

- **Desktop** has its tabs in a different order. *Location* sits in the top row:

  ![Desktop: the Location tab is in the top row](images/2026-10-15-move-profile-folders/13-desktop-location-tab.png)

**10. Saved Games** holds many games' saves, but it isn't in the left column. Click the address bar at the top of File Explorer, type `%USERPROFILE%` and press Enter. Right-click **Saved Games** → **Properties** → **Location**, and type `D:\Anna\Saved Games`. Then steps 3 to 8 as before.

![Open %USERPROFILE%, right-click Saved Games](images/2026-10-15-move-profile-folders/14-saved-games-address.png)

![Saved Games: type the new path](images/2026-10-15-move-profile-folders/15-saved-games-location.png)

**11. Check.** Type `D:\Anna` in the address bar. All seven folders should be there, with their own icons. Open a few and check that your files are there. Then restart the PC once and start your programs and games: they find their files in the new place by themselves.

![D:\Anna after moving all folders](images/2026-10-15-move-profile-folders/16-d-anna-after.png)

An empty folder named Desktop may stay behind in `C:\Users\Anna`. That's harmless; Windows uses the one on D:.

## Part 2: programs that keep their files in AppData

Some programs store big things (photo libraries, caches, game mods) in the hidden folder `C:\Users\<name>\AppData`, and offer no setting to change that. Those folders have no *Location* tab:

![A program folder in AppData: no Location tab](images/2026-10-15-move-profile-folders/17-photoapp-no-location.png)

**First look in the program's own settings.** Many programs (Steam libraries, Lightroom catalogs, browser download folders) have an option to store data elsewhere. That is always better than the trick below. For Steam games: *Steam → Settings → Storage* lets you add a library on D: and move games there.

If there's no such option, you can move the folder and leave a **junction** behind: a signpost at the old place that sends the program to D:. The program doesn't notice. There's no button for this in Windows, so you paste a few lines into Command Prompt.

**1. Find the folder.** In the File Explorer address bar type `%APPDATA%` and press Enter. Look for the program's folder. In this test it was `PhotoApp`. Some programs use `%LOCALAPPDATA%` instead; try that too. Right-click the folder → *Properties* shows how big it is. Only move folders that are big; small ones aren't worth it.

**2. Close the program.** Also check the icons near the clock.

**3. Open Command Prompt.** Press **Windows key + R**, type `cmd`, press Enter. A black window opens. You don't need to run it as administrator.

**4. Paste the block.** Copy the gray block below. In the **first two lines**, replace `TestApp` with the folder name from step 1. If the folder was in `%LOCALAPPDATA%`, also replace `%APPDATA%` with `%LOCALAPPDATA%` in the first line. Click in the black window, press **Ctrl+V**, and then **Enter** once more so the last line runs too. If Windows asks about pasting several lines, click *Paste anyway*.

```bat
set "APP=%APPDATA%\TestApp"
set "NEW=D:\%USERNAME%\AppData\TestApp"
set "ATTR=" & for %I in ("%APP%") do @set "ATTR=%~aI"
if not exist "%APP%" (echo NOT FOUND: check the folder name on the first line.) else if "%ATTR:~8,1%"=="l" (echo ALREADY DONE: this folder already points to D:.) else (robocopy "%APP%" "%NEW%" /E /MOVE /R:1 /W:1 /NP /NFL /NDL & if exist "%APP%" (echo. & echo STOP: a program still uses this folder. Close it and paste these lines again.) else (mklink /J "%APP%" "%NEW%"))
```

What it does: it moves the files to `D:\<your name>\AppData\<folder>`, and only when the old folder is completely empty and gone, it puts the junction in its place. If anything is left behind it stops and changes nothing else. Pasting it a second time is safe.

**5. Read the result.** Good: the table shows `FAILED 0` and the last line says **Junction created for … <<===>> D:\…**.

![The block: all files moved, junction created](images/2026-10-15-move-profile-folders/25-block-first-run.png)

If you paste it again later, it only says **ALREADY DONE**:

![Second run: ALREADY DONE, nothing changed](images/2026-10-15-move-profile-folders/26-block-second-run.png)

**If it says STOP**, a program still has a file open. robocopy shows the file with `ERROR 32 … being used by another process`. Nothing is lost: part of the files is already on D:, the rest is still on C:, and the program still works as before.

![STOP: a file is in use](images/2026-10-15-move-profile-folders/18-junction-in-use.png)

To find out which program: press **Windows key + R**, type `resmon`, Enter. Click the **CPU** tab, and in **Associated Handles** type the folder name in the search box and press Enter. The *Image* column shows the program.

![Resource Monitor shows which program holds the folder](images/2026-10-15-move-profile-folders/19-resource-monitor-handles.png)

Close that program from the taskbar (right-click → *Close window*) or from the icons near the clock. Then paste the block again. It moves the rest and creates the junction.

![Close the program](images/2026-10-15-move-profile-folders/20-close-photoapp.png)

![Second try: junction created](images/2026-10-15-move-profile-folders/21-junction-created.png)

**6.** Start the program. It should open as usual, with all its data.

## Undo

**Standard folders (Part 1):** right-click the folder → *Properties* → *Location* → **Restore Default** → **Apply**. Windows asks to create the folder on C: (**Yes**) and to move the files back (**Yes**). C: needs enough free space for this.

![Restore Default](images/2026-10-15-move-profile-folders/10-restore-default.png)

![Restore Default: create the folder on C:](images/2026-10-15-move-profile-folders/11-restore-default-create.png)

![Restore Default: move the files back to C:](images/2026-10-15-move-profile-folders/12-restore-default-move-back.png)

**A junction (Part 2):** close the program, open Command Prompt, change `TestApp` again and paste:

```bat
set "APP=%APPDATA%\TestApp"
set "NEW=D:\%USERNAME%\AppData\TestApp"
rmdir "%APP%" && robocopy "%NEW%" "%APP%" /E /MOVE /R:1 /W:1 /NP /NFL /NDL
```

`rmdir` removes only the signpost, never the files on D:. robocopy then moves the files back to C:.

## If something goes wrong

| What you see | What to do |
|---|---|
| *File In Use* while moving | Close the named program, then *Try Again*. See Part 1, step 7. |
| A program says "Access is denied" when it saves into a moved folder, or you can't create files there | Your account didn't get rights on the new folder. This happened in the test only when Windows' *User Account Control* was switched off during the move. Fix it below. |
| A program can't find its files after Part 1 | It used a fixed path such as `C:\Users\Anna\Documents`. That old path no longer exists after the move. Look in the program's settings for its folder and point it to `D:\Anna\Documents`. Most programs and games ask Windows where Documents is and don't have this problem. |
| The *Location* box shows a OneDrive path | OneDrive backup is on. Turn it off first; see [Before you start](#before-you-start). |
| Two folders show the same files | Two folders were pointed to the same place. Point each back to its own folder with *Restore Default*, then move them again to separate folders. If that fails, see Microsoft's article in [Sources](#sources). |

**Fix "Access is denied".** Right-click **Start** → **Terminal (Admin)** → **Yes**. Type `cmd` and press Enter. Then paste this line, with your own folder in place of `D:\Anna`:

```bat
icacls "D:\Anna" /grant "%USERNAME%":(OI)(CI)F /T /C /Q
```

![Access is denied before the fix](images/2026-10-15-move-profile-folders/22-access-denied.png)

![Answer Yes to the Administrator question](images/2026-10-15-move-profile-folders/23-uac-yes.png)

It should end with `Failed processing 0 files`. This gives your own account full rights on your own folders; it changes nothing else.

![icacls done: 0 failed](images/2026-10-15-move-profile-folders/24-icacls-done.png)

## What not to do

- **Never point a folder at `D:\` itself.** Windows then treats the whole drive as your Documents (or Pictures). Undoing that can try to move everything on D: back to C:. Always use `D:\<your name>\<folder>`.
- **Never point two folders at the same place**, for example Pictures into `D:\Anna\Documents`. Windows merges them and you can't cleanly separate them again (Microsoft documents this; see [Sources](#sources)).
- **Don't move the whole `C:\Users` folder or one complete user profile.** Microsoft supports that only when Windows is installed with it; afterwards it breaks Store apps and can make Windows updates fail.
- **Don't junction all of `AppData` or `AppData\Local`.** Windows and Store apps keep things there that must stay on C:. Only move single program folders, as in Part 2.
- **Don't move `C:\Program Files` or `C:\ProgramData`.** Reinstall programs to D: instead, if the installer offers it.

## Test evidence

Tested on 2026-10-15 on a temporary virtual machine with **Windows Server 2025** (same File Explorer, Location tab, robocopy and Command Prompt as Windows 11). Disk: C: 70 GB, D: 68 GB "Data", one disk. Everything was clicked through a real desktop session, like a user would; the pictures above come from that run.

**Test data, user Anna** (19,348 files, 19.3 GB, many small files and some big ones):

| Folder | Files | Size |
|---|---:|---:|
| Desktop | 41 | 0.05 GB |
| Documents (incl. a 2 GB zip, a 600 MB `.pst`, game saves in `My Games`) | 12,052 | 3.00 GB |
| Downloads | 301 | 3.16 GB |
| Music | 800 | 3.11 GB |
| Pictures | 4,000 | 4.10 GB |
| Videos | 153 | 5.79 GB |
| Saved Games | 1 | ~0 |
| `AppData\Roaming\PhotoApp` (app with fixed path, 500 MB catalog) | 2,000 | 0.10 GB |

Programs running during the move: Steam (installed on C:), a test game started from Steam's folder that keeps its save in `Documents\My Games` open and writes to it every second, and a test photo program with its library fixed to `%APPDATA%\PhotoApp` that keeps its catalog open.

| Check | Result |
|---|---|
| Part 1, all seven folders via the Location tab | All moved. Registry (`User Shell Folders`) points each to `D:\Anna\…`. Old folders on C: gone (only an empty `Desktop` stayed). C: free space 31.6 → 47.9 GB. |
| Game save open during the Documents move | *File In Use* on `save1.sav`; game closed from the taskbar, *Try Again*, move finished. |
| Restore Default on Videos | Moved 5.79 GB back to C:, then moved to D: again. |
| Part 2 with the photo program running | robocopy `ERROR 32` on `catalog.db`, block printed STOP, no junction. Resource Monitor named `PhotoApp.exe`. After closing it the block finished: junction created. |
| Contents | Every file in all eight folders hashed (MD5, name and size) before and after: identical, except the files the programs were writing to. |
| After restart | Desktop icons load from D:. Steam, the game and the photo program start; the game writes its save into `D:\Anna\Documents\My Games`, the photo program writes new thumbnails and its catalog under `D:\Anna\AppData\PhotoApp`. |

**Finding: "Access is denied".** On this test machine *User Account Control* (UAC) was switched off when Anna moved her folders. The new folders on D: then belonged to the Administrators group instead of Anna. After switching UAC back on (the Windows 11 default), Anna could still read her files but got `Access is denied` when writing, and the game could no longer save. The `icacls` line in [If something goes wrong](#if-something-goes-wrong) fixed it (21,085 files, 0 failed); the game saved again.

**Second user, UAC on (normal Windows 11 setup):** user Bram moved Documents (201 files plus a game save) through the Location tab while the game was running: the same *File In Use* step, then done. The folders on D: belonged to Bram, he could create files and the game saved without any extra step. The Part 2 block was also tested as Bram: first paste moved 50 files and created the junction, a second paste said ALREADY DONE, and the undo lines put the files back on C:.

**Not tested:** a physical Windows 11 PC, OneDrive folder backup, BitLocker on D:, domain or Microsoft-account specifics, and real third-party programs other than Steam.

## Sources

Consulted 2026-10-15.

- Microsoft Learn, [Operation to change a personal folder location fails](https://learn.microsoft.com/en-us/troubleshoot/windows-client/shell-experience/change-personal-folder-location-fails) (updated 2026-02-12): the Location tab steps, the registry values per folder, and the problem when two folders are mapped to each other or to OneDrive.
- Microsoft Learn, [Windows servicing operations fail after you move user profile or ProgramData folders](https://learn.microsoft.com/en-us/troubleshoot/windows-server/setup-upgrade-and-drivers/servicing-fails-moved-user-profile-programdata-folders) (2026-04-23): keep user profile folders and ProgramData on the system drive; updates can fail otherwise.
- Microsoft Learn, [Microsoft Store apps can't start after moving Users or ProgramData](https://learn.microsoft.com/en-us/troubleshoot/windows-client/shell-experience/apps-not-start-without-user-profile-programdata) and [FolderLocations / ProfilesDirectory](https://learn.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-folderlocations-profilesdirectory): moving the whole profile is for test environments only and breaks Store apps.
- Microsoft Learn, [mklink](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/mklink): `/j` creates a directory junction.

---

Text: CC BY 4.0. Command blocks: MIT.
