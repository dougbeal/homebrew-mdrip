#
# Makefile
#
# Copyright (c) 2016 Junpei Kawamoto
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#
VERSION = snapshot

default: build

.PHONY: build
build:
	goxc -d=pkg -pv=$(VERSION)

.PHONY: release
release:
	ghr  -u https://github.com/monopole/mdrip.git  v$(VERSION) pkg/$(VERSION)
