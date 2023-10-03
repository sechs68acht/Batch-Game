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
FOR /f "delims=;" %%i IN (Data\Maps\Map002.mapdat) DO (
if "%%i"=="echo." (
echo.
) else (
echo %%i
))
:A
choice /C 12S /N
if %ERRORLEVEL%==1 (
	set LastMap=!Map!
	set Map=Map001
	goto LoadMap
)
if %ERRORLEVEL%==2 (
	set Msg1=Der Wald ist ruhig und es ist kuehl, denn #
	set Msg2=der Wind weht sanft.                      #
	set MsgLines=2
	goto PrintMessage
)
if %ERRORLEVEL%==3 (
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

:LoadMap
call Data\Maps\!Map!.bat