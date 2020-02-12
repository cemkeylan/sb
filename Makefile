VERSION = 1.4.0

PREFIX = /usr/local
BINDIR = ${PREFIX}/bin
MANPREFIX = ${PREFIX}/share/man

install:
	mkdir -p ${DESTDIR}${BINDIR}
	sed 's#FUNCPATH="./func"#FUNCPATH="${PREFIX}/share/sb-func"#g;s#VERSION="git"#VERSION="${VERSION}"#g' < sb > ${DESTDIR}${BINDIR}/sb
	chmod +x ${DESTDIR}${BINDIR}/sb
	install -Dm644 -t ${DESTDIR}${PREFIX}/share/sb-func func/*
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	mkdir -p ${DESTDIR}${MANPREFIX}/man5
	sed 's#vnumber#${VERSION}#g' < sb.1 > ${DESTDIR}${MANPREFIX}/man1/sb.1
	sed 's#vnumber#${VERSION}#g' < sbrc.5 > ${DESTDIR}${MANPREFIX}/man5/sbrc.5

uninstall:
	rm -rf \
		${DESTDIR}${BINDIR}/sb \
		${DESTDIR}${PREFIX}/share/sb-func \
		${DESTDIR}${MANPREFIX}/man1/sb.1 \
		${DESTDIR}${MANPREFIX}/man5/sbrc.5

.PHONY: install uninstall
