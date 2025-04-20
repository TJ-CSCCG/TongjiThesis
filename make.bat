@echo off

chcp 65001 >nul

REM Basename of thesis
set THESIS=main

REM Parse command line arguments
set TARGET=%1
if "%TARGET%"=="" set TARGET=all

REM Engine handling
set ENGINES=-xelatex -lualatex
set ENGINE=-xelatex
if not "%~2"=="" (
    if "%~2"=="-xelatex" (
        set ENGINE=-xelatex
    ) else if "%~2"=="-lualatex" (
        set ENGINE=-lualatex
    ) else (
        echo Error: Expected $$ENGINE in {-xelatex, -lualatex}, Got "%~2"
        echo Setting default $$ENGINE to "-xelatex"
    )
)

REM LaTeXmk options
set LATEXMK_OPT=-quiet -file-line-error -halt-on-error -interaction=nonstopmode -shell-escape -synctex=1 -recorder %ENGINE%

REM LaTeXmk options for preview continuous mode
set LATEXMK_OPT_PVC=%LATEXMK_OPT% -pvc

REM Check for required programs
where latexmk >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Error: latexmk not found in PATH
    exit /b 1
)

where texcount >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Error: texcount not found in PATH
    exit /b 1
)

REM Execute the requested target
if "%TARGET%"=="all" goto :all
if "%TARGET%"=="pvc" goto :pvc
if "%TARGET%"=="view" goto :view
if "%TARGET%"=="wordcount" goto :wordcount
if "%TARGET%"=="clean" goto :clean
if "%TARGET%"=="cleanall" goto :cleanall
if "%TARGET%"=="help" goto :help
if "%TARGET%"=="thesis" goto :thesis

echo Unknown target: %TARGET%
goto :help

:all
    call :thesis
    if ERRORLEVEL 1 (
        echo.
        echo Error! Please check the %THESIS%.log for more details...
        pause
    ) else (
        echo Finished!
    )
    goto :EOF

:thesis
    echo Building %THESIS%.pdf with %ENGINE%...
    latexmk %LATEXMK_OPT% %THESIS%.tex
    goto :EOF

:pvc
    echo Starting preview continuous mode...
    latexmk %LATEXMK_OPT_PVC% %THESIS%
    goto :EOF

:view
    echo Opening %THESIS%.pdf...
    if exist %THESIS%.pdf (
        start "" "%THESIS%.pdf"
    ) else (
        echo Error: %THESIS%.pdf does not exist. Build it first with 'make all'
    )
    goto :EOF

:wordcount
    echo Counting words in %THESIS%.tex...
    set found=0
    setlocal enabledelayedexpansion
    if not exist %THESIS%.tex (
        echo Error: %THESIS%.tex does not exist.
        exit /b 1
    )

    findstr "\\documentclass\[[^\[]*en" %THESIS%.tex > nul
    if %errorlevel% equ 0 (
        for /f "delims=" %%i in ('texcount %THESIS%.tex -inc -char-only  2^>nul') do (
            if !found! equ 1 (
                echo 英文字符数 Latin characters:!%%i!
                goto :total
            )
            echo %%i | findstr "total" > nul && set found=1
        )
    ) else (
        for /f "delims=" %%i in ('texcount %THESIS%.tex -inc -ch-only  2^>nul') do (
            if !found! equ 1 (
                echo 纯中文字数 Chinese characters:!%%i!
                goto :total
            )
            echo %%i | findstr "total" > nul && set found=1
        )
    )
    goto :total

:total
    set found=0
    for /f "delims=" %%i in ('texcount %THESIS%.tex -inc -chinese 2^>nul') do (
        if !found! equ 1 (
            echo 总字数 Total characters:!%%i!
            goto :EOF
        )
        echo %%i | findstr "total" > nul && set found=1
    )
    if !found! neq 1 (
        echo Warning: Could not determine word count.
    )
    goto :EOF

:clean
    echo Cleaning auxiliary files...
    latexmk -c -bibtex -silent %THESIS%.tex styledef.tex 2>nul
    echo Clean complete.
    goto :EOF

:cleanall
    echo Cleaning all generated files...
    latexmk -C -bibtex -silent %THESIS%.tex styledef.tex 2>nul
    if exist %THESIS%.pdf (
        echo Close the file: '%THESIS%.pdf'!
        pause
        goto :cleanall
    )
    echo Clean complete.
    goto :EOF

:help
    echo Available targets:
    echo   all       - Build PDF (default)
    echo   pvc       - Preview continuously
    echo   view      - Open PDF
    echo   wordcount - Count words in Chinese and English
    echo   clean     - Remove auxiliary files
    echo   cleanall  - Remove all generated files
    echo   help      - Show this help message
    echo   thesis    - Legacy alias for 'all'
    echo.
    echo Available engines (use as second parameter):
    echo   -xelatex (default)
    echo   -lualatex
    echo.
    echo Example usage:
    echo   make
    echo   make all -lualatex
    echo   make pvc
    goto :EOF

exit /B 0
