# sb
# See LICENSE file for copyright and license details.

# sb version
VERSION = 1.1

# path
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

options:
	@echo Installation options for sb
	@echo PREFIX = ${PREFIX}
	@echo MANPREFIX = ${MANPREFIX}
	@echo VERSION = ${VERSION}

install:
	@echo Installing sb to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@sed "s#getfunctionpath#${PREFIX}/share/sb-func#g" < sb | sed "s#vnumber#${VERSION}#g" > ${DESTDIR}${PREFIX}/bin/sb
	@chmod 755 ${DESTDIR}${PREFIX}/bin/sb
	@echo Installing sb function modules to ${DESTDIR}${PREFIX}/share/sb-func
	@mkdir -p ${DESTDIR}${PREFIX}/share/sb-func
	@cp -f func/* ${DESTDIR}${PREFIX}/share/sb-func
	@chmod 644 ${DESTDIR}${PREFIX}/share/sb-func/*
	@echo Installing manuals to ${DESTDIR}${MANPREFIX}
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man5
	@sed "s#vnumber#${VERSION}#g" < sb.1 > ${DESTDIR}${MANPREFIX}/man1/sb.1
	@sed "s#vnumber#${VERSION}#g" < sbrc.5 > ${DESTDIR}${MANPREFIX}/man5/sbrc.5
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/sb.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man5/sbrc.5
	@echo Copying sbrc.example to ${DESTDIR}${PREFIX}/share/sb
	@mkdir -p ${DESTDIR}${PREFIX}/share/sb
	@cp -f sbrc.example ${DESTDIR}${PREFIX}/share/sb/sbrc.example

uninstall:
	@echo Removing sb from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/sb
	@echo Removing sb-func from ${DESTDIR}${PREFIX}/share
	@rm -rf ${DESTDIR}${PREFIX}/share/sb-func
	@echo Removing manuals from ${DESTDIR}${MANPREFIX}
	@rm -f ${DESTDIR}${MANPREFIX}/man1/sb.1
	@rm -f ${DESTDIR}${MANPREFIX}/man5/sbrc.5
	@echo Removing ${DESTDIR}${PREFIX}/share/sb
	@rm -rf ${DESTDIR}${PREFIX}/share/sb

.PHONY: options install uninstall
