# Этот Makefile упрощает работу в IntelliJ IDEA. Нужно установить плагин
# для Makefile’ов Виктора Кроппа (просто набрать makefile в Marketplace).
# Тогда цели этого файла будут доступны для запуска через кнопку Run
# или комбинацию Shift-F10.
#
# Цели с именами на -win запускают .bat-файлы, на -posix — Bash-скрипты.
#
# Можно пользоваться этим Makefile и обычным образом, запуская make
# в командной строке. Но удобнее из командной строки запускать сами скрипты
# непосредственно.


all:
	echo Read Makefile for details


all-win:
	bootstrap.bat

compiler-makeself-win:
	cd src && makeself.bat

compiler-makeself-s-win:
	cd src && makeself.bat stable


all-posix:
	./bootstrap.sh

compiler-makeself-posix:
	cd src && ./makeself.sh

compiler-makeself-s-posix:
	cd src && ./makeself.sh stable

dist:
	rm -rf dist
	mkdir dist
	cp src/cfiles/*.c dist
