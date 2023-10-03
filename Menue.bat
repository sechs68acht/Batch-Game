@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
mode con lines=50 cols=128
if "%a%"=="" (
	echo Bitte fuehre die Datei "Start.bat" aus.
	pause
	exit
)
if "%c1%"=="" set c1=*
if "%c2%"=="" set c2= 
if "%c3%"=="" set c3= 
if "%c4%"=="" set c4= 
:Menue
echo.
echo  #################################################################
echo  #                     ______     ___    _    _     _            #
echo  #         /\  /\     I  ____I   I   \  I I  I I   I I           #
echo  #        /  \/  \    I I___     I I\ \ I I  I I   I I           #
echo  #       / /\__/\ \   I  ___I_   I I \ \I I  I  I_I  I           #
echo  #      /_/      \_\  I_______I  I I  \___I   I_____I            #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                         %c1% Speichern %c1%                         #
echo  #                         %c2% Items %c2%                             #
echo  #                         %c3% Zurueck %c3%                           #
echo  #                         %c4% Hauptmenue %c4%                        #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #                                                               #
echo  #################################################################
choice /C WSD /N
::Taste W wird gedrückt(nach oben)
IF %ERRORLEVEL%==1 goto MenueUp

::Taste S wird gedrückt(nach unten)
IF %ERRORLEVEL%==2 goto MenueDown

::Taste Enter wird gedrückt(Auswahl bestätigen)
IF %ERRORLEVEL%==3 (
	::Speichern
	if "%c1%"=="*" (
		cls
		echo Wahle einen Speicherstand aus. [1-9]
		choice /C 123456789X /N
		if NOT !ERRORLEVEL!==10 (
			if exist Save!ERRORLEVEL!.save (
				cls
				echo Die Speicherstanddatei mit dem Namen "Save!ERRORLEVEL!.save" existiert bereits.
				echo Bitte loesch sie vorher damit sie neugespeichert werden kann.
				pause>NUL
				goto Menue
			) else (
				set code=%Map%
				set back=SaveMap
				goto EncryptSave
				:SaveMap
				echo !code!>> Save!ERRORLEVEL!.save
				
				set code=%LastMap%
				set back=SaveLastMap
				goto EncryptSave
				:SaveLastMap
				echo !code!>> Save!ERRORLEVEL!.save
				
				set code=%item1%
				set back=SaveItem1
				goto EncryptSave
				:SaveItem1
				echo !code!>> Save!ERRORLEVEL!.save
				
				set code=%item2%
				set back=SaveItem2
				goto EncryptSave
				:SaveItem2
				echo !code!>> Save!ERRORLEVEL!.save
				
				set code=%item3%
				set back=SaveItem3
				goto EncryptSave
				:SaveItem3
				echo !code!>> Save!ERRORLEVEL!.save
				
				echo Erfolgreich gespeichert.
				pause>NUL
				goto Menue
			)
		) else (
			goto Menue
		)
	)
	
	::Items
	if "%c2%"=="*" (
		call Data\Items.bat
	)
	
	::Zurueck
	if "%c3%"=="*" (
		set c1=
		set c2=
		set c3=
		set c4=
		call Data\Maps\%Map%.bat
	)
	
	::Hauptmenue
	if "%c4%"=="*" (
		set c1=
		set c2=
		set c3=
		set c4=
		call Start.bat
	)
)

::Auswahl wird nach oben verschoben
:MenueUp
if "%c2%"=="*" (
	set c1=*
	set c2= 
	set c3= 
	set c4= 
) else (
	if "%c3%"=="*" (
		set c1= 
		set c2=*
		set c3= 
		set c4= 
	) else (
		if "%c4%"=="*" (
			set c1= 
			set c2= 
			set c3=*
			set c4= 
		)
	)
)
goto Menue

::Auswahl wird nach unten verschoben
:MenueDown
if "%c1%"=="*" (
	set c1= 
	set c2=*
	set c3= 
	set c4= 
) else (
	if "%c2%"=="*" (
		set c1= 
		set c2= 
		set c3=*
		set c4= 
	) else (
		if "%c3%"=="*" (
			set c1= 
			set c2= 
			set c3= 
			set c4=*
		)
	)
)
goto Menue

:EncryptSave
set chars=0123456789abcdefghijklmnopqrstuvwxyz
for /l %%N in (10 1 36) do (
	for /f %%C in ("!chars:~%%N,1!") do (
		set "code=!code:%%C=%%N!"
	)
)
set chars=
goto %back%
pause>NUL