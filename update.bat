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
    del /f chrome-win32.zip
) || (
    pause
)


:EOF
@echo on
