@echo off
setlocal enabledelayedexpansion

REM Debug: Log the arguments to see what Unity is passing
echo Arguments received: >> "C:\Users\marcu\Documents\UnityToNvim\unity_debug.log"
echo File: "%~1" >> "c:\Users\marcu\Documents\UnityToNvim\unity_debug.log"
echo Line: "%~2" >> "c:\Users\marcu\Documents\UnityToNvim\unity_debug.log"
echo Time: %date% %time% >> "c:\Users\marcu\Documents\UnityToNvim\unity_debug.log"
echo. >> "c:\Users\marcu\Documents\UnityToNvim\unity_debug.log"

REM Check if file argument exists
if "%~1"=="" (
    echo No file specified
    pause
    exit /b 1
)

REM Change to project directory
cd /d "C:\Users\marcu\Documents\Hardship\Hardship-Town-Survival\Assets\Scripts"

REM Try to connect to existing Neovim instance
nvim --server localhost:6969 --remote-send ":echo 'Testing connection'<CR>" >nul 2>&1
if errorlevel neq 0 (
    REM No existing instance found, start a new one
    echo Starting new Neovim instance with remote listening >> "C:\Users\marcu\Documents\UnityToNvim\unity_debug.log"
    echo Starting Neovim server on localhost:6969...
    
    REM Start Neovim with remote listening in background
    if "%~2"=="" (
        start nvim --listen localhost:6969 "%~1"
    ) else (
        start nvim --listen localhost:6969 "+%~2" "%~1"
    )
    
    REM Wait a moment for the server to start
    timeout /t 2 /nobreak >nul
    
    echo Neovim server started successfully.
) else (
    REM Existing instance found, open file in new tab
    echo Opening file in existing Neovim instance in new tab >> "C:\Users\marcu\Documents\UnityToNvim\unity_debug.log"
    
    REM Open file in new tab using remote commands
    if "%~2"=="" (
        REM Open file without line specification
        nvim --server localhost:6969 --remote-send ":tabnew<CR>" && nvim --server localhost:6969 --remote-send ":edit %~1<CR>"
    ) else (
        REM Open file with line specification
        nvim --server localhost:6969 --remote-send ":tabnew<CR>" && nvim --server localhost:6969 --remote-send ":edit %~1<CR>" && nvim --server localhost:6969 --remote-send ":%~2<CR>"
    )
) 