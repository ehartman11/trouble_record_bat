@echo off
setlocal enabledelayedexpansion
cls
goto :main

:view
	echo.
	setlocal
	echo Trouble Record:
	for /f "tokens=* delims=" %%a in (info.txt) do (
		echo %%a
	)
	endlocal
goto :main

:clear
	echo.
	setlocal
	for /f "tokens=* delims=" %%y in (info.txt) do (
		echo %%y
	)
	echo.
	set /p tbd=Enter the id of the entry would you like to delete? 
	set /a tbd=%tbd%
	echo.
	echo running check...
	
	for /f "tokens=1-4 delims=^|" %%a in (info.txt) do (
		if %tbd% neq %%a (
			echo %%a^|%%b^|%%c >> temp.txt
		) else (
			echo deleting entry %%a
		)
	)
	echo outputting record
	echo.
	del info.txt
	rename temp.txt info.txt
	for /f "tokens=* delims=" %%a in (info.txt) do (
		echo %%a
	)
	endlocal
goto :main

:Submit
	setlocal 
	echo.
	set /a counter=0
	echo input your ticket below:
	set /p ticket=^>^> 
	
	for /f "tokens=1 delims=^|" %%a in (info.txt) do (
		set counter=%%a
	)
	
	if %counter%==id (
		set counter=1
	) else (
		set /a counter=%counter% + 1
	)
	echo %counter%^| %date% ^| %time% ^| %username% ^| %ticket% >> info.txt
	endlocal 
goto :main
	
	
:main
	setlocal
	echo.
	echo Which action would you like to take^?
	echo 1 Submit a trouble ticket
	echo 2 View trouble record
	echo 3 Clear a trouble ticket
	echo 4 Cancel
	set /p action=^>^> 
	if %action%==1 (
		goto :Submit
	)
	if %action%==2 (
		goto :view
	)
	if %action%==3 (
		goto :clear
	)
	if %action%==4 (
		goto :eof
	)
	endlocal
