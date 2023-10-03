@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
mode con lines=50 cols=128
set a=1
:: Hier werden die "Auswahlsternchen" initialisiert
if "%c1%"=="" set c1=*
if "%c2%"=="" set c2= 
if "%c3%"=="" set c3= 

:: Hier beginnt das Menue
:Menue
cls
echo.
echo  ##############################################################################################################################
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #    ______     ___________          ____          _____       __        __    ___________    ___    __        __    ______  #
echo  #   / _____I   I____   ____I       /      \       I      \    \   \    /   /  I____   ____I  I   I  I  \      /  I  I   ___I #
echo  # /  /              I I          /    __    \     I   _    \    \   \/   /         I I       I   I  I   \    /   I  I  I     #
echo  # I  \_____         I I        /    /    \    \   I  I I   I      \    /           I I       I   I  I    \  /    I  I  I___  #
echo  #  \______ \        I I       I    I      I    I  I  I_/   /       I  I            I I       I   I  I     \/     I  I   ___I #
echo  #        I  I       I I        \    \ __ /    /   I   ___/         I  I            I I       I   I  I  I\    /I  I  I  I     #
echo  #  _____/  /        I I          \          /     I     \          I  I            I I       I   I  I  I \  / I  I  I  I___  #
echo  # I_______/         I_I            \ ____ /       I__I\__\         I__I            I_I       I___I  I__I  \/  I__I  I______I #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                 __________________________________________________________________________________________                 #
echo  #                  I                                                                                      I                  #
echo  #                  I  *                                                                                *  I                  #
echo  #                  I                                          ___                                         I                  #
echo  #                  I                                %c1% I\  I  I     I   I  %c1%                               I                  #
echo  #                  I                                %c1% I \ I  I---  I   I  %c1%                               I                  #
echo  #                  I                                %c1% I  \I  I___  I___I  %c1%                               I                  #
echo  #                  I                                   __    __     ___                                   I                  #
echo  #                  I                         %c2% I      /__\  I  \   I     I\  I  %c2%                         I                  #
echo  #                  I                         %c2% I      I  I  I   I  I---  I \ I  %c2%                         I                  #
echo  #                  I                         %c2% I____  I  I  I__/   I___  I  \I  %c2%                         I                  #
echo  #                  I                       ___    __   _____      ___           ____                      I                  #
echo  #                  I                    %c3% / _ \  I__I    I    I  / _ \  I\  I  /      %c3%                   I                  #
echo  #                  I                    %c3% I _ I  I       I    I  I _ I  I \ I  \---\  %c3%                   I                  #
echo  #                  I                    %c3% \___/  I       I    I  \___/  I  \I  ____/  %c3%                   I                  #
echo  #                  I                                                                                      I                  #
echo  #                  I                                                                                      I                  #
echo  #                  I                                                                                      I                  #
echo  #                  I                                                                                      I                  #
echo  #                  I  *                                                                                *  I                  #
echo  #                 _I______________________________________________________________________________________I_                 #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  ##############################################################################################################################
choice /C WSD /N
::Taste W wird gedrückt(nach oben)
IF !ERRORLEVEL!==1 goto MenueUp

::Taste S wird gedrückt(nach unten)
IF !ERRORLEVEL!==2 goto MenueDown

::Taste Enter wird gedrückt(Auswahl bestätigen)
IF !ERRORLEVEL!==3 (
	::Neues Spiel wird geladen
	if "%c1%"=="*" (
		set c1=
		set c2=
		set c3=
		set itemlist=0
		set item1=0
		set item2=0
		set item3=0
		set Map=Map001
		set LastMap=Map001
		call Data\Maps\Map001.bat
	)
	
	::Speicherstand wird geladen
	if "%c2%"=="*" goto LoadGame
	
	::Optionen werden geladen
	if "%c3%"=="*" goto Options
	pause
)
goto Menue

::Auswahl wird nach oben verschoben
:MenueUp
if "%c2%"=="*" (
	set c1=*
	set c2= 
	set c3= 
) else (
	if "%c3%"=="*" (
		set c1= 
		set c2=*
		set c3= 
	)
)
goto Menue

::Auswahl wird nach unten verschoben
:MenueDown
if "%c1%"=="*" (
	set c1= 
	set c2=*
	set c3= 
) else (
	if "%c2%"=="*" (
		set c1= 
		set c2= 
		set c3=*
	)
)
goto Menue

:: Hier werden die Optionen angezeigt
:Options
cls
echo Noch nicht vorhanden
pause>NUL
goto Menue

:: Hier wird der Speicherstand geladen
:LoadGame
cls
echo Waehle einen Speicherstand aus. [1-9]
choice /C 123456789X /N
if NOT !ERRORLEVEL!==10 (
	if exist Save!ERRORLEVEL!.save (
		set /a strArrayNumber=0
		for /f "usebackq" %%i in (`type Save!ERRORLEVEL!.save`) do (
			set /a strArrayNumber=!strArrayNumber! + 1
			set Save!strArrayNumber!=%%i
		)
		set c1=
		set c2=
		set c3=
		set itemlist=0
		set item1=0
		set item2=0
		set item3=0
		
		set code=!Save1!
		set back=LoadMap
		goto DecryptSave
		:LoadMap
		set Map=!code!
		
		set code=!Save2!
		set back=LoadLastMap
		goto DecryptSave
		:LoadLastMap
		set LastMap=!code!
		
		set code=!Save3!
		set back=LoadItem1
		goto DecryptSave
		:LoadItem1
		set Item1=!code!
		
		set code=!Save4!
		set back=LoadItem2
		goto DecryptSave
		:LoadItem2
		set Item2=!code!
		
		set code=!Save5!
		set back=LoadItem3
		goto DecryptSave
		:LoadItem3
		set Item3=!code!
		
		set Savefile=!ERRORLEVEL!
		::Der Speicherstand wurde erfolgreich geladen
		echo Der Speicherstand "Save!ERRORLEVEL!.save" wurde erfolgreich geladen.
		pause>NUL
		set c1=
		set c2=
		set c3=
		call Data\Maps\!Map!.bat
	) else (
		::Der Speicherstand existiert nicht.
		echo Der Speicherstand mit dem Namen "Save!ERRORLEVEL!.save" existiert nicht.
		pause>NUL
		goto Menue
	)
) else (
goto Menue
)

:DecryptSave
set chars=0123456789abcdefghijklmnopqrstuvwxyz
for /l %%N in (10 1 36) do (
	for /f %%C in ("!chars:~%%N,1!") do (
		set "code=!code:%%N=%%C!"
	)
)
set chars=
goto %back%