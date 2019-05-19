:: creates folder bginfo in %PROGRAMDATA% and copies files there
:: creates scheduled task to execute on
::   - user who installed it at login
::   - every 15 minutes
::   - 3 seconds after network change happens
::     specificly events from NetworkProfile/Operational - 10000, 10001, 4004
:: there is bginfo_update_NOW.lnk that can be used to run the task on demand
:: editing scheduled task and running it as group "users" will run it for all

@echo off

:: check if the script is run as administrator

net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
) else (
    echo RUN AS ADMINISTRATOR
    pause
    exit /B
)

:: variable for path where files are saved
SET target=C:\ProgramData\bginfo

:: create direcotry ignore messages if exists
mkdir %target% 2> NUL

:: robocopy stuff around <source folder> <destination> <what files>
:: %~dp0 represent path to the folder where this script is run, even as admin
:: to make it work with paths with spaces it needs to be in ""
:: but since %~dp0 ends with a trailing / , we need to add another /
:: otherwise the closing " would be ignored.
robocopy "%~dp0/" %target% Bginfo64.exe bginfo_preset.bgi active_ip4.vbs bginfo_update_NOW.lnk bginfo_preset_clean.bgi

:: import scheduled task with many triggers
schtasks.exe /Create /XML "%~dp0\bginfo_scheduled_task.xml" /tn "BgInfo"
schtasks.exe /run /tn "BgInfo"

pause

