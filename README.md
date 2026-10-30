# ShapeWin — Non-Rectangular Window Library for OS/2 PM

**Version 2.01**

ShapeWin is a custom PM control (widget) that implements shape
(non-rectangular) windows for OS/2 Presentation Manager.  It works by
maintaining an invisible frame window alongside a shaped child window
whose visible region is determined by a mask bitmap.

Originally written by Akira Hatakeyama / Software Research Associates.
Version 2.01 is an OS2World community port adding an OpenWatcom 2.0
build system and fixing two bugs present in 2.00.

## License

GNU Lesser General Public License v2.1 or later.  See `doc/LGPL_en.txt`.

The sample bitmaps in `sample/bitmaps/` are converted from artwork by
Mr. Watanabe (go@denpa.org) and are distributed as hobby materials only
(not for commercial use).

## Contents

```
h/               Public header: shapewin.h
src/             Library source: shapewin.c, shapewin.def
dll/             Build output — SHAPEWIN.DLL (after build)
lib/             Build output — SHAPEWIN.LIB import library (after build)
sample/          Three sample PM programs + bitmaps
doc/             Documentation, changelog, license texts
Makefile.wat     OpenWatcom 2.0 build file
compile_wat.cmd  Build script for the DLL (run on ArcaOS / OS/2)
compile_samples.cmd  Build script for the sample programs
```

## Building

Requires **OpenWatcom 2.0** and the **OS/2 Toolkit 4.5** installed at
`C:\WATCOM` and `C:\os2tk45` respectively, plus IBM RC from the Toolkit.

Build the DLL:

```
compile_wat.cmd
```

Build the sample programs (requires the DLL to be built first):

```
compile_samples.cmd
```

Output: `dll\shapewin.dll`, `lib\shapewin.lib`, `sample\*.exe`.

## API Overview

Register the window class once per process, then create shape windows
with `WinCreateWindow`.  See `doc/shapewin_en.txt` for the full API
description.

```c
#include <shapewin.h>

/* 1. Register the class */
ShapeWinInit(hab);

/* 2. Create a shape window */
SHAPEWIN sw;
sw.cx     = width;
sw.cy     = height;
sw.hpsMask = ...; /* memory PS defining the shape */
sw.hpsDraw = ...; /* memory PS with the drawing data */
hwndShape = WinCreateWindow(HWND_DESKTOP, ShapeWinName,
                            NULL, 0L,
                            x, y, 0, 0,
                            hwndOwner, HWND_TOP,
                            id, &sw, NULL);

/* 3. Update the contents */
WinSendMsg(hwndShape, SHAPEWIN_MSG_UPDATE, (MPARAM)prcl, NULL);
```

## Sample Programs

| Program | Description |
|---------|-------------|
| `trbitmap.exe bitmap.bmp` | Displays a bitmap with transparent background; drag with right mouse button |
| `tranime.exe [-d ms] [-s n] bmp1 bmp2 ...` | Animates a sequence of bitmaps |
| `treyes.exe` | Xeyes-style eye tracker that follows the mouse pointer |

Sample bitmaps are in `sample/bitmaps/`.  Example:

```
trbitmap.exe sample\bitmaps\misa.bmp
tranime.exe -d200 sample\bitmaps\azumi01.bmp sample\bitmaps\azumi02.bmp
treyes.exe
```

## Changelog

See `doc/CHANGELOG.txt` for the full version history.

**2.01** (2026-10-29) — OpenWatcom build port (OS2World community)
- Added `Makefile.wat` / `compile_wat.cmd` / `compile_samples.cmd`
- Reorganized source tree (`src/`, `h/`, `dll/`, `lib/`, `sample/`, `doc/`)
- Fixed `ShapeWinInit()` calling convention (`_System`) in `shapewin.h`
- Fixed unconditional `fflush(stdout)` in `parseMask()` causing SYS3175 trap

**2.00** (Dec 2001) — Converted to DLL; license changed to LGPL

**1.02** — CPU speedup patch (Ulrich Moeller)

**1.01** — Mouse event notifications; CPU speedup patch (Takayuki Suwa)

**1.00** — First release (Akira Hatakeyama / SRA)

## Links

- Original homepage: http://home.d04.itscom.net/ath/old/os2/shapewin-en.html
- OS2World: https://www.os2world.com
