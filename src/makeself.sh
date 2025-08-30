#!/bin/bash
set -ue
(
  MODULES="refal05c R05-CompilerUtils R05-Generator R05-Parser"
  LIBS="LibraryEx R5FW-Parser-Defs R5FW-Parser R5FW-Plainer"
  LIBS="${LIBS} R5FW-Transformer Platform"

  mkdir -p ../bin

  EXECUTABLE="../bin/refal05c"

  source ../c-plus-plus.conf.sh
  export R05CFLAGS="-o refal05c -DR05_SHOW_STAT $R05CFLAGS"
  export R05PATH=../lib:.:cfiles
  echo Y | ${EXECUTABLE} ${MODULES} ${LIBS} Library refal05rts

  # Копирование необходимо при компиляции при помощи Cygwin или MSYS,
  # поскольку на платформе Windows невозможно перезаписать исполнимый
  # файл, если соответствующая ему программма выполняется.
  # Поэтому создаём файл в текущей папке и перекладываем в ../bin
  mv refal05c ../bin

  mkdir -p cfiles
  mv *.c cfiles
)
