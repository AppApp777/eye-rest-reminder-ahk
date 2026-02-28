@echo off
setlocal

net session >nul 2>&1
if %errorlevel% neq 0 (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)

set "SETUP_PS1=D:\claude code\setup_eye_rest_autostart.ps1"

if not exist "%SETUP_PS1%" (
  echo Setup script not found:
  echo %SETUP_PS1%
  pause
  exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%SETUP_PS1%"
if %errorlevel% neq 0 (
  echo Failed to create/start scheduled task.
  pause
  exit /b 1
)

echo Scheduled task created and started: EyeRestReminder_AutoStart
echo It will run at logon with highest privileges.
pause
exit /b 0
