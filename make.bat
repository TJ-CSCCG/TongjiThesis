@echo off

chcp 65001 >nul

set THESIS=main

if "%~1" == "" (
	set flag=thesis
) else (
    set flag=%1
)

if %flag% == thesis (
	call :cleanall
	call :thesis
	if ERRORLEVEL 1 (
		echo.
		echo Error! Please check the %THESIS%.log for more details . . .
		pause
	) else (
		call :clean
		echo Finished!
		pause
	)
	goto :EOF
)

if %flag% == clean (
	call :clean
	goto :EOF
)

if %flag% == cleanall (
	call :cleanall
	goto :EOF
)

if %flag% == wordcount (
	call :wordcount
	goto :EOF
)

:help
	echo This is the compile batch script for tongji-undergrad-thesis.
	echo Usage:
	echo     make.bat [option]
	echo options:
	echo   thesis    Compile the thesis (default)
	echo   clean     Clean all work files
	echo   cleanall  Clean all work files and main.pdf
	echo   wordcount Count words in main.pdf
	echo   help      Print this help message
goto :EOF

:thesis
	echo Compile . . .
	latexmk -xelatex -synctex=1 -quiet -interaction=nonstopmode -file-line-error -halt-on-error -shell-escape %THESIS% 2>nul
goto :EOF

:clean
	echo Clean files . . .
	latexmk -quiet -c %THESIS% 2>nul
goto :EOF

:cleanall
	echo Clean all files . . .
	latexmk -quiet -C %THESIS% 2>nul
	if exist %THESIS%.pdf (
		echo Close the file: '%THESIS%.pdf'!
		pause
		call :cleanall
	)
goto :EOF

:wordcount
	set found=0
	setlocal enabledelayedexpansion

	findstr "\\documentclass\[[^\[]*en" %THESIS%.tex > nul
	if %errorlevel% equ 0 (
		for /f "delims=" %%i in ('texcount %THESIS%.tex -inc -char-only  2^>nul') do (
			if !found! equ 1 (
				echo 英文字符数			:!%%i!
				goto :total
			)
			echo %%i | findstr "total" > nul && set found=1
		)
	) else (
		for /f "delims=" %%i in ('texcount %THESIS%.tex -inc -ch-only  2^>nul') do (
			if !found! equ 1 (
				echo 纯中文字数			:!%%i!
				goto :total
			)
			echo %%i | findstr "total" > nul && set found=1
		)
	)

:total
	set found=0
	for /f "delims=" %%i in ('texcount %THESIS%.tex -inc -chinese 2^>nul') do (
		if !found! equ 1 (
			echo 总字数（英文单词 + 中文字）	:!%%i!
			goto :EOF
		)
		echo %%i | findstr "total" > nul && set found=1
	)
goto :EOF

exit /B 0