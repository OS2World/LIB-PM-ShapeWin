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
        file dll\shapewin.obj &
        library C:\WATCOM\lib386\os2\os2386.lib &
        library C:\WATCOM\lib386\os2\clib3r.lib

clean: .SYMBOLIC
    @if exist dll\*.obj del dll\*.obj
    @if exist dll\*.map del dll\*.map
    @if exist dll\*.dll del dll\*.dll
    @if exist lib\*.lib del lib\*.lib

WATCOM = C:\WATCOM
RC     = C:\os2tk45\bin\rc.exe

SCFLAGS = -bt=os2 -mf -5 -fpi -Oaxt -W3 -ze &
          -I=h -I=sample -I=$(OS2TK)\h -I=$(WATCOM)\H

SLIBS = lib\shapewin.lib &
        library $(WATCOM)\lib386\os2\os2386.lib

samples: sample\trbitmap.exe sample\tranime.exe sample\treyes.exe .SYMBOLIC

# Shared bitmap-load helper
sample\bmpload.obj: sample\bmpload.c ; $(CC) $(SCFLAGS) -fo=$^@ $<

# trbitmap
sample\trbitmap.obj: sample\trbitmap.c ; $(CC) $(SCFLAGS) -fo=$^@ $<
sample\trbitmap.res: sample\trbitmap.rc
    C:\OS2\CMD.EXE /c "cd sample & $(RC) -r -I ..\h -I . -I $(OS2TK)\h trbitmap.rc trbitmap.res"
sample\trbitmap.exe: sample\trbitmap.obj sample\bmpload.obj sample\trbitmap.res lib\shapewin.lib
    $(WLINK) system os2v2_pm &
        name sample\trbitmap.exe &
        option stack=65536 &
        option map=sample\trbitmap.map &
        file sample\trbitmap.obj &
        file sample\bmpload.obj &
        lib $(SLIBS)
    $(RC) sample\trbitmap.res sample\trbitmap.exe

# tranime
sample\tranime.obj: sample\tranime.c ; $(CC) $(SCFLAGS) -fo=$^@ $<
sample\tranime.res: sample\tranime.rc
    C:\OS2\CMD.EXE /c "cd sample & $(RC) -r -I ..\h -I . -I $(OS2TK)\h tranime.rc tranime.res"
sample\tranime.exe: sample\tranime.obj sample\bmpload.obj sample\tranime.res lib\shapewin.lib
    $(WLINK) system os2v2_pm &
        name sample\tranime.exe &
        option stack=65536 &
        option map=sample\tranime.map &
        file sample\tranime.obj &
        file sample\bmpload.obj &
        lib $(SLIBS)
    $(RC) sample\tranime.res sample\tranime.exe

# treyes (no bmpload needed)
sample\treyes.obj: sample\treyes.c ; $(CC) $(SCFLAGS) -fo=$^@ $<
sample\treyes.res: sample\treyes.rc
    C:\OS2\CMD.EXE /c "cd sample & $(RC) -r -I ..\h -I . -I $(OS2TK)\h treyes.rc treyes.res"
sample\treyes.exe: sample\treyes.obj sample\treyes.res lib\shapewin.lib
    $(WLINK) system os2v2_pm &
        name sample\treyes.exe &
        option stack=65536 &
        option map=sample\treyes.map &
        file sample\treyes.obj &
        lib $(SLIBS)
    $(RC) sample\treyes.res sample\treyes.exe

cleansample: .SYMBOLIC
    @if exist sample\*.obj del sample\*.obj
    @if exist sample\*.res del sample\*.res
    @if exist sample\*.map del sample\*.map
    @if exist sample\*.exe del sample\*.exe