@echo off

start "chrome" "%~dp0chrome-win32\chrome.exe" --no-first-run --allow-running-insecure-content --ppapi-flash-path="%~dp0pepflashplayer.dll" --ppapi-flash-version=17.0.0.99 --User-data-dir="%~dp0Data" --disk-cache-dir="%USERPROFILE%\ChromeCache" 

@echo on
