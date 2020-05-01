#!/bin/bash

#
# This script is inspired by Karl Landstrom's install script for
# obnc-libext_0.7.0.tar.gz
#

set -o errexit -o nounset

readonly srcDir=$(pwd)
readonly libName="$(basename "${srcDir}" | tr '[:upper:]' '[:lower:]')"
readonly docName="$(basename "${srcDir}")"
readonly modules="$(ls *.Mod | grep -v 'Test\.Mod$' | while read -r file; do basename "${file%.Mod}"; done)"

prefix="${HOME}"
libdir="lib"
destdir=

destIncludeDir=
destLibDir=
destObncdocDir=

includeLibCSrc=false

function run() {
	echo "$@"
	eval "$@"
}

function update_obncdoc_index() {
	if obncdoc-index >/dev/null 2>&1; then
		run obncdoc-index \> index.html
	fi
}

function install_modules() {
	# install our library modules
	run mkdir -p "$destIncludeDir"
	run mkdir -p "$destLibDir"
	local module=
	for module in $modules; do
		run cp "$srcDir/.obnc/$module.h" "$destIncludeDir"
		run cp "$srcDir/.obnc/$module.o" "$destLibDir"
		run cp "$srcDir/.obnc/$module.sym" "$destLibDir"
		if [[ -e "$srcDir/.obnc/$module.imp" ]]; then
			run cp "$srcDir/.obnc/$module.imp" "$destLibDir"
		fi
		if [[ -e "$srcDir/$module.env" ]]; then
			run cp "$srcDir/$module.env" "$destLibDir"
		fi
		if "$includeLibCSrc"; then
			local source="$srcDir/$module.c"
			if [[ ! -e "$source" ]]; then
				source="$srcDir/.obnc/$module.c"
			fi
			run sed -e "'s|#include \"\(\.obnc/\)\?$module\.h\"|#include <obnc/ext/$module.h>|'" "'$source'" \> "'$destLibDir/$module.c'"
		fi
	done

	#install documentation
	run mkdir -p "$destObncdocDir"
	run cp "$srcDir/obncdoc/$docName"* "$destObncdocDir"
	for file in "$srcDir/obncdoc/"*; do
		if [[ "$file" == "${file%Test.*}" ]]; then
			run cp "$file" "$destObncdocDir"
		fi
	done
	update_obncdoc_index
}

function uninstall_modules() {
	# delete the module files
	local module=
	for module in $modules; do
		run rm -f "$destIncludeDir/$module.h"
		run rm -f "$destLibDir/$module.o"
		run rm -f "$destLibDir/$module.sym"
		run rm -f "$destLibDir/$module.imp"
		run rm -f "$destLibDir/$module.env"
		run rm -f "$destLibDir/$module.c"
	done

	# delete module documentation
	run rm -f "$destObncdocDir"/*
	update_obncdoc_index
}

function usage() {
	echo "usage: "
	printf "\tinstall.bash [u] [--prefix=PREFIX] [--libdir=LIBDIR] [--destdir=DESTDIR] [--include-lib-c-src]\n"
	printf "\tinstall.bash -h\n"
	echo
	printf "\tu\t\t\tuninstall\n"
	printf "\t--prefix\t\ttoplevel installation dir instead of /usr/local\n"
	printf "\t--libdir\t\tlibrary installation directory instead of lib\n"
	printf "\t--destdir\t\tspecify directory for staged installation\n"
	printf "\t--include-lib-c-src\tmake cross compilation possible\n"
	printf "\t-h\t\t\tdisplay help and exit\n"
}

uninstall=false
for arg in "$@"; do
	case "$arg" in
	uninstall)
		uninstall=true
		;;
	--prefix=*)
		prefix="${arg#--prefix=}"
		if [ "${prefix#/}" = "$prefix" ]; then
			echo "prefix must be an absolute path: $prefix" >&2
			exit 1
		fi
		;;
	--libdir=*)
		libdir="${arg#--libdir=}"
		if [ "${libdir#*/}" != "$libdir" ]; then
			echo "libdir must be a prefix relative path, not an absolute path: $prefix" >&2
			exit 1
		fi
		;;
	--destdir=*)
		destdir="${arg#--destdir=}"
		;;
	--include-lib-c-src)
		includeLibCSrc=true
		;;
	-h)
		usage
		exit
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

# NOTE:  Build our paths after considering the args
destIncludeDir="$destdir$prefix/include/obnc/"
destLibDir="$destdir$prefix/$libdir/obnc/"
destObncdocDir="$destdir$prefix/share/doc/obnc/obncdoc/$docName"

if "$uninstall"; then
	uninstall_modules
else
	install_modules
fi
