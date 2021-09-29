---
title: Makefile
date: 2020-07-14 12:00:43
tags: Makefile
---

### Makefile
SUBDIR=
#SUBDIR=./xxx
CLEANSUBDIR=$(SUBDIR)

VER=
git_ver=$(shell git describe --tags `git rev-list --tags --max-count=1`)
<!--more-->
all:$(SUBDIR)
$(SUBDIR):ECHO
ifeq ("$(VER)","")
	@echo "##################################################################################"
	@echo "###########            ## PLEASE SET XXX VERSION ##                     ##########"
	@echo "########### 1.Set The XXX Version By Youself //Make VER=x.x.x           ##########"
	@echo "########### 2.Set The XXX  Version By Latest Git tag //Make VER=git     ##########"
	@echo "##################################################################################"
else ifeq ("$(VER)","git")
	#@cd ..
	make -C $@
else
	#@cd ..
	make -C $@


endif

clean:
	-for x in $(SUBDIR) ; do make -C $$x clean; done

ECHO:
	@echo $(SUBDIR)
