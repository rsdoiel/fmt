#!/bin/bash

#
# This script is inspired by Karl Landstrom's test script for
# obnc-libext_0.7.0.tar.gz
#

set -o errexit -o nounset

for file in *Test.Mod; do
	obnc "$file" >/dev/null
	module="${file%.Mod}"
	if [[ -e "$module.sh" ]]; then
		if ! "./$module.sh"; then
			echo "$module.sh failed"
			exit 1
		fi
	else
		if ! "./$module"; then
			echo "./$module failed"
			exit 1
		fi
	fi
done

printf "\nSuccess!\n\n"
