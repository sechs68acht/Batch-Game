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
FOR /f "delims=;" %%i IN (Data\Maps\Map001.mapdat) DO (
if "%%i"=="echo." (
echo.
) else (
echo %%i
))
:A
choice /C 1234S /N
if %ERRORLEVEL%==1 (
	set LastMap=!Map!
	set Map=Map002
	goto LoadMap
)
if %ERRORLEVEL%==2 (
	set Msg1=Dein Freund ist grade nicht zuhause.               #
	set Msg2=Seine Tuer ist zwar nicht verschlossen,            #
	set Msg3=dennoch waere es nicht nett jetzt hinein zu gehen. #
	set MsgLines=3
	goto PrintMessage
)
if %ERRORLEVEL%==3 (
	set Msg1=Herr Sanders ist grade nicht zuhause. #
	set Msg2=Seine Tuer ist verschlossen.          #
	set MsgLines=2
	goto PrintMessage
)
if %ERRORLEVEL%==4 (
	set item1=1
	set Msg1=Du gehst nach hause und holst deine Pistole, die unter #
	set Msg2=Deinem Kopfkissen versteckt ist.                       #
	set MsgLines=2
	goto PrintMessage
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

:LoadMap
call Data\Maps\!Map!.bat