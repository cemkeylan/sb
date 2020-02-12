VERSION = 1.3.1-p1

PREFIX = /usr/local
BINDIR = ${PREFIX}/bin
MANPREFIX = ${PREFIX}/share/man
CONF = \$$HOME/.config/sbrc

all: sb

sb:
	sed 's#conffile#${CONF}#g;s#VERSION="git"#VERSION="${VERSION}"#g' sb.in > sb
	chmod +x sb

clean:
	rm -f sb

install: all
	mkdir -p ${DESTDIR}${BINDIR}
	sed 's#FUNCPATH="./func"#FUNCPATH="${PREFIX}/share/sb-func"#g' < sb > ${DESTDIR}${BINDIR}/sb
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

.PHONY: all install clean uninstall
