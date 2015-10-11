@echo off
@pushd %~dp0

set HTTPS_PROXY=http://127.0.0.1:8000

wget -O LAST_CHANGE --no-check-certificate https://commondatastorage.googleapis.com/chromium-browser-snapshots/Win/LAST_CHANGE

(
    fc LAST_CHANGE chrome-win32\LAST_CHANGE
) && (
    echo Already Lastest Version !
) || (
    for /f %%I in (LAST_CHANGE) do (
        wget -O chrome-win32.zip --no-check-certificate https://commondatastorage.googleapis.com/chromium-browser-snapshots/Win/%%I/chrome-win32.zip
    )
) && (
    7za x chrome-win32.zip
) && (
    copy /y LAST_CHANGE "chrome-win32\LAST_CHANGE"
) && (
    if not exist "%~dp0User Data" (md "%~dp0User Data")   
) && (
    del /f chrome-win32.zip
)

if exist "%~dp0Chromium.lnk" (
    shortcut.exe /A:E /F:"%~dp0Chromium.lnk" /T:"%~dp0chrome-win32\chrome.exe" /P:"--ppapi-flash-version=17.0.0.999 --ppapi-flash-path=\"%~dp0pepflashplayer.dll\" --allow-outdated-plugins --allow-running-insecure-content --User-data-dir=\"%~dp0User Data\""
)

pause

:EOF
@echo on
