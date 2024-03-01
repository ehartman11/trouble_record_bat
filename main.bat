@echo off
setlocal enabledelayedexpansion
goto :main

:main
	cls
	echo Enter command or cancel^?
	set /p input=
	if %input%==cancel (
		goto :eof
	) else (
		call %input%
	)
goto :main
