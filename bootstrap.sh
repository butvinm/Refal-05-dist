#!/bin/bash
set -ue
if [ ! -e c-plus-plus.conf.sh ]; then
  cp lib/c-plus-plus.conf.sh.template c-plus-plus.conf.sh
fi

MODULES="refal05c R05-CompilerUtils R05-Generator R05-Parser"
LIBS="LibraryEx R5FW-Parser-Defs R5FW-Parser R5FW-Plainer"
LIBS="${LIBS} R5FW-Transformer Platform"

source c-plus-plus.conf.sh

mkdir -p bin

# Сборка из dist/
$R05CCOMP -DR05_SHOW_STAT -I./lib -o./bin/refal05c-bootstrap \
  $(for m in ${MODULES} ${LIBS}; do echo dist/${m}.c; done) lib/refal05rts.c lib/Library.c

chmod +x bin/refal05c-bootstrap
( cd src && export R05CFLAGS="-o ../bin/refal05c -DR05_SHOW_STAT ${R05CFLAGS:-}" && export R05PATH=../lib:.:cfiles && echo Y | ../bin/refal05c-bootstrap ${MODULES} ${LIBS} Library refal05rts )
( cd src && mkdir -p cfiles && mv *.c cfiles )
( cd autotests && ./run.sh )