@echo off
@pushd %~dp0

@netstat -an|find "LISTENING"|find ":8087" && set HTTPS_PROXY=127.0.0.1:8087

wget -O LAST_CHANGE --no-check-certificate --header "Host: commondatastorage.googleapis.com" https://www.google.com.hk/chromium-browser-snapshots/Win/LAST_CHANGE

(
    fc LAST_CHANGE chrome-win32\LAST_CHANGE
) && (
    echo Already Lastest Version ! && pause>NUL
) || (
    for /f %%I in (LAST_CHANGE) do (
        wget -O chrome-win32.zip --no-check-certificate --header "Host: commondatastorage.googleapis.com" https://www.google.com.hk/chromium-browser-snapshots/Win/%%I/chrome-win32.zip
    )
) && (
    7za x chrome-win32.zip
) && (
    copy /y LAST_CHANGE "chrome-win32\LAST_CHANGE"
) && (
    if not exist "chrome-win32\plugins" (md "chrome-win32\plugins")
    for %%I in ("np*.dll") do (
      copy /y "%%~I" "chrome-win32\plugins\%%~nxI"
    )
) && (
    if not exist "%~dp0User Data" (md "%~dp0User Data")
) && (
    for %%I in ("Chromium.lnk", "%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Chromium.lnk") do (
        if exist "%%~I" (
            shortcut.exe /A:E /F:"%%~I" /T:"%~dp0chrome-win32\chrome.exe" /P:"--allow-running-insecure-content --ppapi-flash-path=\"%~dp0pepflashplayer.dll\" --ppapi-flash-version=17.0.0.999 --User-data-dir=\"%~dp0User Data\""
        )
    )
) && (
    del /f chrome-win32.zip
) || (
    pause
)


:EOF
@echo on
