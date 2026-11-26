@echo off

chcp 65001 >nul

REM Basename of thesis
set THESIS=main

REM Basenames of the standalone administrative documents (task book, opening
REM report, mid-term report) — each is its own tongjithesis document, sharing
REM chapters/metadata.tex but selected via the doctype= class option.
set FORMS=taskbook proposal midterm

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
set LATEXMK_OPT=-quiet -file-line-error -halt-on-error -interaction=nonstopmode -shell-escape -synctex=1 -recorder -usepretex="\listfiles" %ENGINE%

REM LaTeXmk options for preview continuous mode
set LATEXMK_OPT_PVC=%LATEXMK_OPT% -pvc

REM Only build and cleanup targets need latexmk.
if "%TARGET%"=="help" goto :help
if "%TARGET%"=="view" goto :view
if "%TARGET%"=="wordcount" goto :wordcount
for %%T in (all thesis pvc taskbook proposal midterm forms clean cleanall) do if "%TARGET%"=="%%T" goto :buildtarget

echo Unknown target: %TARGET%
goto :help

:buildtarget
    where latexmk >nul 2>&1
    if errorlevel 1 (
        echo Error: latexmk not found in PATH
        exit /b 1
    )
    goto :%TARGET%

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

:taskbook
    echo Building taskbook.pdf with %ENGINE%...
    latexmk %LATEXMK_OPT% taskbook.tex
    goto :EOF

:proposal
    echo Building proposal.pdf with %ENGINE%...
    latexmk %LATEXMK_OPT% proposal.tex
    goto :EOF

:midterm
    echo Building midterm.pdf with %ENGINE%...
    latexmk %LATEXMK_OPT% midterm.tex
    goto :EOF

:forms
    call :taskbook
    if ERRORLEVEL 1 (
        echo Error building taskbook.pdf - see taskbook.log for details
        exit /b 1
    )
    call :proposal
    if ERRORLEVEL 1 (
        echo Error building proposal.pdf - see proposal.log for details
        exit /b 1
    )
    call :midterm
    if ERRORLEVEL 1 (
        echo Error building midterm.pdf - see midterm.log for details
        exit /b 1
    )
    echo Finished!
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
    where texcount >nul 2>&1
    if errorlevel 1 (
        echo Error: texcount not found in PATH
        exit /b 1
    )
    echo Counting words in %THESIS%.tex...
    if not exist %THESIS%.tex (
        echo Error: %THESIS%.tex does not exist.
        exit /b 1
    )

    findstr "\\documentclass\[[^\[]*english" %THESIS%.tex >nul
    if errorlevel 1 (
        call :count -ch-only "纯中文字数 Chinese characters"
    ) else (
        call :count -char-only "英文字符数 Latin characters"
    )
    if errorlevel 1 exit /b 1
    call :count -chinese "总字数 Total characters"
    exit /b %errorlevel%

:count
    for /f "tokens=4" %%n in ('texcount %THESIS%.tex -inc -total %1 2^>nul ^| findstr /b /c:"Words in text:" /c:"Letters in text:"') do (
        echo %~2: %%n
        exit /b 0
    )
    echo Error: Could not determine word count.
    exit /b 1

:clean
    echo Cleaning auxiliary files...
    latexmk -c -bibtex -silent %THESIS%.tex 2>nul
    for %%f in (%FORMS%) do (
        latexmk -c -bibtex -silent %%f.tex 2>nul
    )
    echo Clean complete.
    goto :EOF

:cleanall
    echo Cleaning all generated files...
    latexmk -C -bibtex -silent %THESIS%.tex 2>nul
    for %%f in (%FORMS%) do (
        latexmk -C -bibtex -silent %%f.tex 2>nul
    )
    if exist %THESIS%.pdf (
        echo Close the file: '%THESIS%.pdf'!
        pause
        goto :cleanall
    )
    for %%f in (%FORMS%) do (
        if exist %%f.pdf (
            echo Close the file: '%%f.pdf'!
            pause
            goto :cleanall
        )
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
    echo   taskbook  - Build taskbook.pdf (毕业设计（论文）任务书)
    echo   proposal  - Build proposal.pdf (毕业设计（论文）开题报告)
    echo   midterm   - Build midterm.pdf (毕业设计（论文）中期报告)
    echo   forms     - Build taskbook.pdf, proposal.pdf, and midterm.pdf
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
    echo   make forms
    goto :EOF

exit /B 0
