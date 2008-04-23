PREFIX := /usr

VERSION = $(shell grep version setup.py|sed -e "s/^[^']*//;s/[',]//g;")

all: build

clean:
	PREFIX=$(PREFIX) python setup.py clean
	rm -f augeas.py _augeas.so augeas_wrap.c

distclean: clean
	rm -fr build dist MANIFEST

build:
	PREFIX=$(PREFIX) python setup.py build_ext -i
	PREFIX=$(PREFIX) python setup.py build

install:
	PREFIX=$(PREFIX) python setup.py install

sdist:
	PREFIX=$(PREFIX) python setup.py sdist

srpm: sdist
	rpmbuild -ts --define "_srcrpmdir ."  dist/python-augeas-$(VERSION).tar.gz

.PHONY: sdist install build clean distclean srpm
