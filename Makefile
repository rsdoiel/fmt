#
# Simple Makefile for conviently testing, building and deploying experiment.
#
PROJECT = Fmt

VERSION = $(shell grep -m 1 'Version\* = ' $(PROJECT).Mod | cut -d\"  -f 2)

BRANCH = $(shell git branch | grep '* ' | cut -d\  -f 2)

PREFIX = $(HOME)

OS = $(shell uname)
MACHINE = $(shell uname -m)
PLATFORM = $(MACHINE)_$(OS)

EXT = 
ifeq ($(OS), Windows)
	EXT = .exe
endif

PROJECT_LIST =

build: .FORCE
	./build.bash

install: .FORCE
	./install.bash --prefix=$(PREFIX)

obncdocs: .FORCE
	./build.bash docs

website: obncdocs page.tmpl README.md nav.md INSTALL.md LICENSE css/site.css
	python3 mk_website.py

test:
	./test.bash

cleanweb:
	if [ -f index.html ]; then rm *.html; fi

clean: .FORCE
	if [ -d dist ]; then rm -fR dist; fi
	./build.bash clean

distribute_docs:
	mkdir -p dist/$(PROJECT)-$(VERSION)
	cp -v README.md  dist/$(PROJECT)-$(VERSION)/
	cp -v LICENSE    dist/$(PROJECT)-$(VERSION)/
	cp -v INSTALL.md dist/$(PROJECT)-$(VERSION)/

dist/$(PLATFORM)-$(VERSION): distribute_docs
	mkdir -p dist/$(PROJECT)-$(VERSION)
	cp *.Mod dist/$(PROJECT)-$(VERSION)/
	cp *.bash dist/$(PROJECT)-$(VERSION)/
	cp -r obncdoc dist/$(PROJECT)-$(VERSION)/
	cd dist && zip -r $(PROJECT)-$(VERSION).zip $(PROJECT)-$(VERSION)/* 

update_version:
	python3 update_version.py --yes

release: clean website dist/$(PLATFORM)-$(VERSION)

status:
	git status

save:
	if [ "$(msg)" != "" ]; then git commit -am "$(msg)"; else git commit -am "Quick Save"; fi
	git push origin $(BRANCH)

publish:
	python3 mk_website.py
	bash publish.bash

.FORCE:
