@echo off
setlocal
  set MODULES=refal05c R05-CompilerUtils R05-Generator R05-Parser
  set LIBS=LibraryEx R5FW-Parser-Defs R5FW-Parser R5FW-Plainer
  set LIBS=%LIBS% R5FW-Transformer Platform

  md ..\bin 2>NUL

  set EXECUTABLE=..\bin\refal05c.exe

  call ..\c-plus-plus.conf.bat
  set R05CFLAGS=-Fe ..\bin\refal05c.exe -DR05_SHOW_STAT %R05CFLAGS%
  set R05PATH=..\lib;.;cfiles
  echo Y|%EXECUTABLE% %MODULES% %LIBS% Library refal05rts
  if exist *.obj erase *.obj
  if exist *.tds erase *.tds

  md cfiles 2>NUL
  move *.c cfiles >NUL
endlocal
