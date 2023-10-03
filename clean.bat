@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
mode con lines=50 cols=128
if "%a%"=="" (
	echo Bitte fuehre die Datei "Start.bat" aus.
	pause
	exit
)
:PrintMap
cls
FOR /f "delims=;" %%i IN (Data\Maps\NAME.mapdat) DO (   <------------------------------ Namen ändern zu "MapXXX"
if "%%i"=="echo." (
echo.
) else (
echo %%i
))
:A
choice /C 1234S /N
if %ERRORLEVEL%==1 (
	
)
if %ERRORLEVEL%==2 (
	
)
if %ERRORLEVEL%==3 (
	
)
if %ERRORLEVEL%==4 (
	
)
if %ERRORLEVEL%==5 (
	call Data\Menue.bat
)

pause>NUL

:PrintMessage
for /l %%I in (1 1 45) do (
	if NOT [Msg%%I]==[] (
		set Msg%%I= # !Msg%%I!
	)
)
echo %Msg1%> temp.tmp
for %%? in (temp.tmp) do ( set /a varlength=%%~z? - 2 )
set /a varlength=%varlength%-1
del "temp.tmp"
set box1= 
for /l %%? in (1,1,%varlength%) do ( set box1=!box1!# )
SET box1=%box1: =%
set box2=#
set /a varlength=%varlength%-2
for /l %%? in (1,1,%varlength%) do ( set box2=!box2!- )
set box2=!box2!#
set box2=%box2: =%
cls
echo.
echo  %box1%
echo  %box2%
for /l %%i in (1,1,%MsgLines%) do ( 
set Msg=!Msg%%i!
if %MsgLines% GEQ %%i echo !Msg!
)
echo  %box2%
echo  %box1%
pause>NUL
goto PrintMap