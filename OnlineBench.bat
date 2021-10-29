@echo off
color A
set version=V1.0
title OnlineBench %version%
cls
goto 0
:0
IF EXIST speedtest.exe (
goto 1
) else (
goto error
)
:1
IF EXIST speedtest.md (
goto 2
) else (
goto error
)
:2
cls
for /f "tokens=1* delims=: " %%A in (
  'nslookup myip.opendns.com. resolver1.opendns.com 2^>NUL^|find "Address:"'
) Do set ExtIP=%%B
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
Ping 8.8.8.8 -n 1 -w 1000 >nul
cls
if errorlevel 1 (set internet=false) else (set internet=true)
if %internet% == false goto error2
cls
echo Welcome to OnlineBench by MGK.
echo Press any key to start the benchmark
echo System internet info:
echo.
echo Local adress:
echo %NetworkIP%
echo.
echo Public adress:
echo %ExtIP%
echo.
echo.
echo batchfile Made with ♡ by MGK
echo Copyright of speedtest to Ookla's Speedtest.net
pause >nul
cls
speedtest.exe
choice /C RE /M "Press R to redo and Press E to exit"
if %ERRORLEVEL% EQU 2 goto stop
if %ERRORLEVEL% EQU 1 goto 0
:stop
exit
:error
cls
echo Unable to start. Please check if the files speedtest.exe and speedtest.md are in the same directory of the script. Error Code #0001
echo Press any key to retry.
pause >nul
goto 0
:error2
cls
echo Unable to start. Please check your internet connection. Error Code #0002
echo Press any key to retry.
pause >nul
goto 0