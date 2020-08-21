# RunAsAdmin
Collection of other peoples work, combined to create a solution for running Apps from standard users as admin in a not horrific and unsecure way.

**Note** - I never intended to share this solution, I have created it from different scripts and solutions found across the web to suit my requirements. Please contact me if you want me to remove code or add references.

## End Solution
End User runs a shortcut which runs a .exe, the following files are needed:
* PsExec.exe (part of [Microsoft Sysinternals](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec "Microsoft Sysinternals"))
* App-AsAdmin.exe (PowerShell Script Wrapped in .exe)
* Key File used to Decrypt the Password (I store this on a network share)
* Password File used to store the encrypted password (I store this on a network share)

## Step 1 - Create Key File for Encryption
1. Run PowerShell Script - CreateAESKey.ps1
2. This will create a file in the same directory called 'AES.key'.

## Step 2 - Create file containing Password, encrypted using the Key File from Step 1
1. Edit the password on Line 3 in 'CreatePasswordFile.ps1', in between quote marks to your required password.
2. Run PowerShell Script - CreatePasswordFile.ps1

## Step 3 - Decisions, Decisions, Decisions
1. You now need to place your 'AES.key' and 'Password.txt' somewhere where the end user and client PC will be able to access them, they can be in different locations, e.g. Password could be on local PC and Key could be on a network share, doesn't need to be a drive, could be a UNC path.

## Step 4 - Update PowerShell Script (RunAs-AppName.ps1)
1. Update Line 1 with the username of the user that you need to run your application as.
2. Update Line 2 with the path to the Password File created in Step 2.
3. Update Line 3 with the path to the Key File created in Step 1.
4. Update Line 9 with the path to your .exe that you want to Run As Admin.

## Step 4 - Testing
1. I assume by now you have placed the Key File and Password File in their final locations, if not do it now.
2. Place the PowerShell Script (RunAS-AppName.ps1) and PsExec.exe in the same folder on the client PC.
3. Open PowerShell, browse to the folder, run the script. It should open your app as whichever user you specified. This method also highlights issues with paths or the contents of files.
**NOTE** I have used this for a few apps with success but have also had another app that wouldn't work at all, your mileage may very.

## Step 5 - Wrap your PowerShell script as a .exe
**NOTE** The purpose of this step is to hide what you are doing with the PowerShell script and stop a user just changing the .exe that your script is running to any other file, e.g. Notepad, allowing them to browse and edit any file on the computer, or regedit, etc.

1. Download the Ps2Exe Script from the TechNet Gallery (now available on GitHut)
~~https://gallery.technet.microsoft.com/scriptcenter/PS2EXE-GUI-Convert-e7cb69d5~~
https://github.com/MScholtes/TechNet-Gallery/tree/master/PS2EXE-GUI

2. Follow the scripts instructions to create a .exe for your PowerShell script.

**NOTE** Should probably add some more instructions here, maybe in the future. Let me know if you get stuck, happy to help if I can.

## Step 6 - Implementation
You should now have create the Key File (Step 1), a Password File (Step 2) and your .exe (Step 5) from your script (Step 4).
1. Copy the PsExec and RunAs-AppName.exe (not .ps1) to the client pc, ideally in a folder away from the users profile/desktop.
2. Create a shortcut from the RunAs-AppName.exe and add it to the user's desktop or start menu, you can even change the shortcut icon by using the icon in the original program's .exe file.
