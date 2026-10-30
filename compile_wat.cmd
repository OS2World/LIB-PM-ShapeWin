@ECHO OFF
ECHO.
ECHO === ShapeWin OpenWatcom Build ===
ECHO.

SET WATCOM=C:\WATCOM
SET OS2TK=C:\os2tk45
SET PATH=%WATCOM%\BINP;%WATCOM%\BINW;%OS2TK%\bin;C:\usr\bin;%PATH%
SET INCLUDE=%OS2TK%\H;%WATCOM%\H;%WATCOM%\H\OS2

IF NOT EXIST dll MD dll
IF NOT EXIST lib MD lib

ECHO Building...
wmake -f Makefile.wat 2>&1 | tee -a compile_wat.log

IF ERRORLEVEL 1 GOTO FAIL

ECHO.
ECHO Build OK: dll\shapewin.dll  lib\shapewin.lib
ECHO Log: compile_wat.log
GOTO END

:FAIL
ECHO.
ECHO BUILD FAILED - check compile_wat.log
EXIT /B 1

:END
