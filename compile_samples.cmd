@ECHO OFF
ECHO.
ECHO === ShapeWin Samples OpenWatcom Build ===
ECHO.

SET WATCOM=C:\WATCOM
SET OS2TK=C:\os2tk45
SET PATH=%WATCOM%\BINP;%WATCOM%\BINW;%OS2TK%\bin;C:\usr\bin;%PATH%
SET INCLUDE=%OS2TK%\H;%WATCOM%\H;%WATCOM%\H\OS2
SET DPATH=%OS2TK%\msg;%DPATH%

IF NOT EXIST sample MD sample

ECHO Building samples...
wmake -f Makefile.wat samples 2>&1 | tee -a compile_samples.log

IF ERRORLEVEL 1 GOTO FAIL

ECHO.
ECHO Build OK: sample\trbitmap.exe  sample\tranime.exe  sample\treyes.exe
ECHO Log: compile_samples.log
GOTO END

:FAIL
ECHO.
ECHO BUILD FAILED - check compile_samples.log
EXIT /B 1

:END
