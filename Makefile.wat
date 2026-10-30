# Makefile.wat - OpenWatcom 2.0 build for ShapeWin PM shape-window DLL
# Run from project root:  wmake -f Makefile.wat
# Full build with log:    compile_wat.cmd
#
# Output:  dll\shapewin.dll   (DLL)
#          lib\shapewin.lib   (import library, created by wlink)

.ERASE

CC    = wcc386
WLINK = wlink

OS2TK = C:\os2tk45

CFLAGS = -bt=os2 -mf -5 -fpi -Oaxt -W3 -ze &
         -I=h -I=$(OS2TK)\h

all: directories dll\shapewin.dll .SYMBOLIC

directories: .SYMBOLIC
    -md dll
    -md lib

dll\shapewin.obj: src\shapewin.c ; $(CC) $(CFLAGS) -fo=$^@ $<

dll\shapewin.dll: dll\shapewin.obj
    $(WLINK) system os2v2_dll &
        name dll\shapewin.dll &
        option implib=lib\shapewin.lib &
        option map=dll\shapewin.map &
        option manyautodata &
        export ShapeWinInit.1 &
        export ShapeWinProc.2 &
        file dll\shapewin.obj

clean: .SYMBOLIC
    @if exist dll\*.obj del dll\*.obj
    @if exist dll\*.map del dll\*.map
    @if exist dll\*.dll del dll\*.dll
    @if exist lib\*.lib del lib\*.lib
