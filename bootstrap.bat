@echo off
setlocal
set MODULES=refal05c R05-CompilerUtils R05-Generator R05-Parser
set LIBS=LibraryEx R5FW-Parser-Defs R5FW-Parser R5FW-Plainer R5FW-Transformer Platform

if not exist c-plus-plus.conf.bat (
  copy lib\c-plus-plus.conf.bat.template c-plus-plus.conf.bat
)
call c-plus-plus.conf.bat
if not exist bin mkdir bin

rem Сборка из dist\
%R05CCOMP% -DR05_SHOW_STAT -I.\lib -Fe.\bin\refal05c-bootstrap.exe ^
  dist\refal05c.c dist\R05-CompilerUtils.c dist\R05-Generator.c ^
  dist\R05-Parser.c dist\LibraryEx.c dist\R5FW-Parser-Defs.c ^
  dist\R5FW-Parser.c dist\R5FW-Plainer.c dist\R5FW-Transformer.c ^
  dist\Platform.c lib\refal05rts.c lib\Library.c

cd src
set R05CFLAGS=-Fe ..\bin\refal05c.exe -DR05_SHOW_STAT %R05CFLAGS%
set R05PATH=..\lib;.;cfiles
echo Y | ..\bin\refal05c-bootstrap.exe %MODULES% %LIBS% Library refal05rts
if not exist cfiles mkdir cfiles
move *.c cfiles\
cd ..\autotests
call run.bat
cd ..
endlocal