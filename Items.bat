@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
mode con lines=50 cols=128
if "%a%"=="" (
	echo Bitte fuehre die Datei "Start.bat" aus.
	pause
	exit
)
if %item1%==1 set /a itemlist+=1
if %item2%==1 set /a itemlist+=1
if %item3%==1 set /a itemlist+=1
if %itemlist%==0 (
	echo Du hast keine Items.
	pause>NUL
	call Data\Menue.bat
)
if %item1%==1 set items=!items!1 
if %item2%==1 set items=!items!2 
if %item3%==1 set items=!items!3 
set count=0
for %%a in (%items%) do (
	set /a count+=1
	set itemid!count!=%%a
)
set itemsite=1
:PrintScreen
cls
echo.
for /f "delims=;" %%i in (Data\Items\Item!itemid%itemsite%!.itemdat) do (
echo %%i
)
if %itemsite%==1 (
	if %itemlist%==1 (
		goto PrintRest1
	) else (
		goto PrintRest2
	)
) else (
	if %itemsite%==%itemlist% (
		goto PrintRest4
	) else (
		goto PrintRest3
	)
)
:PrintScreenEnd
choice /C ADX /N
if %ERRORLEVEL%==1 (
	if NOT %itemsite%==1 (
		set /a itemsite-=1
	)
) else (
	if %ERRORLEVEL%==2 (
		if NOT %itemsite%==%itemlist% (
			set /a itemsite+=1
		)
	) else (
		if %ERRORLEVEL%==3 (
			call Data\Menue.bat
		)
	)
)

goto PrintScreen





:PrintRest1
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  #                                                                                                                            #
echo  ##############################################################################################################################
goto PrintScreenEnd

:PrintRest2
echo  #                                                                                                                            #
echo  #                                                                                                            #############   #
echo  #                                                                                                            #   ---     #   #
echo  #                                                                                                            #   I   \   #   #
echo  #                                                                                                            #   I    )  #   #
echo  #                                                                                                            #   I   /   #   #
echo  #                                                                                                            #   ---     #   #
echo  #                                                                                                            #############   #
echo  #                                                                                                                            #
echo  ##############################################################################################################################
goto PrintScreenEnd

:PrintRest3
echo  #                                                                                                                            #
echo  #   #############                                                                                            #############   #
echo  #   #    ---    #                                                                                            #   ---     #   #
echo  #   #  /    I   #                                                                                            #   I   \   #   #
echo  #   # (     I   #                                                                                            #   I    )  #   #
echo  #   #  \    I   #                                                                                            #   I   /   #   #
echo  #   #    ---    #                                                                                            #   ---     #   #
echo  #   #############                                                                                            #############   #
echo  #                                                                                                                            #
echo  ##############################################################################################################################
goto PrintScreenEnd

:PrintRest4
echo  #                                                                                                                            #
echo  #   #############                                                                                                            #
echo  #   #    ---    #                                                                                                            #
echo  #   #  /    I   #                                                                                                            #
echo  #   # (     I   #                                                                                                            #
echo  #   #  \    I   #                                                                                                            #
echo  #   #    ---    #                                                                                                            #
echo  #   #############                                                                                                            #
echo  #                                                                                                                            #
echo  ##############################################################################################################################
goto PrintScreenEnd