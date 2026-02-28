@echo off
setlocal

net session >nul 2>&1
if %errorlevel% neq 0 (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)

set "APP_NAME=EyeRestReminder"
set "TASK_NAME=EyeRestReminder_AutoStart"
set "INSTALL_DIR=%ProgramFiles%\%APP_NAME%"
set "AHK_EXE=C:\Users\11626\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe"
set "SCRIPT_SRC=%~dp0eye_rest_reminder.ahk"
set "SCRIPT_DST=%INSTALL_DIR%\eye_rest_reminder.ahk"
set "START_BAT=%INSTALL_DIR%\StartEyeRestReminder.bat"
set "UNINSTALL_BAT=%INSTALL_DIR%\Uninstall.bat"

if not exist "%AHK_EXE%" (
  echo AutoHotkey v2 not found at:
  echo %AHK_EXE%
  echo Please install AutoHotkey v2 first.
  pause
  exit /b 1
)

if not exist "%SCRIPT_SRC%" (
  echo Script not found:
  echo %SCRIPT_SRC%
  pause
  exit /b 1
)

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
copy /Y "%SCRIPT_SRC%" "%SCRIPT_DST%" >nul

(
  echo @echo off
  echo start "" "%AHK_EXE%" "%SCRIPT_DST%"
) > "%START_BAT%"

(
  echo @echo off
  echo setlocal
  echo net session ^>nul 2^>^&1
  echo if %%errorlevel%% neq 0 ^(
  echo   powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%%~f0' -Verb RunAs"
  echo   exit /b
  echo ^)
  echo schtasks /delete /tn "%TASK_NAME%" /f ^>nul 2^>^&1
  echo taskkill /IM AutoHotkey64.exe /F ^>nul 2^>^&1
  echo rmdir /S /Q "%INSTALL_DIR%"
  echo echo Uninstalled %APP_NAME%.
  echo pause
) > "%UNINSTALL_BAT%"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $taskName='%TASK_NAME%'; $exe='%AHK_EXE%'; $script='%SCRIPT_DST%'; $work='%INSTALL_DIR%'; $user=\"$env:USERDOMAIN\\$env:USERNAME\"; Get-ScheduledTask | Where-Object { $_.TaskName -eq $taskName } | ForEach-Object { Unregister-ScheduledTask -TaskName $_.TaskName -TaskPath $_.TaskPath -Confirm:$false }; $action=New-ScheduledTaskAction -Execute $exe -Argument ('\"'+$script+'\"') -WorkingDirectory $work; $trigger=New-ScheduledTaskTrigger -AtLogOn; $principal=New-ScheduledTaskPrincipal -UserId $user -LogonType Interactive -RunLevel Highest; $settings=New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable; Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Force | Out-Null; Start-ScheduledTask -TaskName $taskName"
if %errorlevel% neq 0 (
  echo Failed to register/start autostart task.
  pause
  exit /b 1
)

echo Installed to: %INSTALL_DIR%
echo Autostart task: %TASK_NAME%
echo Uninstall script: %UNINSTALL_BAT%
pause
exit /b 0
