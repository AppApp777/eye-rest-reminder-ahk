@echo off
setlocal

set "TASK_NAME=EyeRestReminder_AutoStart"

net session >nul 2>&1
if %errorlevel% neq 0 (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)

schtasks /delete /tn "%TASK_NAME%" /f
if %errorlevel% neq 0 (
  echo Task not found or delete failed: %TASK_NAME%
  pause
  exit /b 1
)

echo Removed scheduled task: %TASK_NAME%
pause
exit /b 0
