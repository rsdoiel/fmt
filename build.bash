#!/bin/bash

#
# This script is inspired by Karl Landstrom's build script for
# obnc-libext_0.7.0.tar.gz
#
set -o errexit -o nounset

function run() {
	echo "$@"
	eval "$@"
}

function build_obncdocs() {
	run obncdoc
}

function build_modules() {
	for test in ?*Test.Mod; do
		run obnc "$test"
	done
	run obncdoc
}

function clean_modules() {
	if [[ -d "./.obnc" ]]; then
		rm -rf "./.obnc"
	fi
	for FNAME in *Test; do
		rm -f "${FNAME}"
	done
	if [[ -d "obncdoc" ]]; then
		rm -rf "obncdoc"
	fi
}

function usage() {
	echo "usage: "
	printf "\tbuild [clean|docs]\n"
	printf "\tbuild -h\n"
	echo
	printf "\tclean\tdelete all generated files\n"
	printf "\t-h\tdisplay help and exit\n"
}

for arg in "$@"; do
	case "$arg" in
	docs)
		build_obncdocs
		exit 0
		;;
	clean)
		clean_modules
		exit 0
		;;
	-h)
		usage
		exit 0
		;;
	*)
		{
			echo "invalid command"
			usage
		} >&2
		exit 1
		;;
	esac
done

build_modules
