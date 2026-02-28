@echo off
setlocal

set "AHK_EXE=C:\Users\11626\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe"
set "SCRIPT_PATH=D:\claude code\eye_rest_reminder.ahk"

if not exist "%AHK_EXE%" (
  echo AutoHotkey executable not found:
  echo %AHK_EXE%
  pause
  exit /b 1
)

if not exist "%SCRIPT_PATH%" (
  echo Reminder script not found:
  echo %SCRIPT_PATH%
  pause
  exit /b 1
)

start "" "%AHK_EXE%" "%SCRIPT_PATH%"
exit /b 0
