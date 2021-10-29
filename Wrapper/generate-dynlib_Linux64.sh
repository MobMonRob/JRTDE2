#!/bin/bash

scriptPath="$(realpath -s "${BASH_SOURCE[0]}")"
scriptDir="$(dirname "$scriptPath")"
cd "$scriptDir"

source "./_bash_config.sh"

run() {
	mkdir -p "$linuxTarget"

	local -r wrapLibTarget="$wrapLibDir/$linuxTarget"
	local -r wrapLibInclude="$wrapLibTarget/include"
	local -r wrapLibBinary="$wrapLibTarget/lib"

	#-flto
	#-c für nicht linken (nur .o erzeugen)
	#-shared .so muss tun, damit sicher der Fehler nicht hier liegt.
	g++ -c -fPIC -O3 -cpp -std=c++17 "$linuxTmp/"$wrapLibName"_wrap.cpp" \
	-I"$javaIncludeLinux/linux" -I"$javaIncludeLinux" -I"$wrapLibInclude" \
	-o "$linuxTmp/lib"$wrapLibName"_wrap.o"

	#-flto
	g++ -shared "$linuxTmp/lib"$wrapLibName"_wrap.o" -L"$wrapLibBinary" \
	-lurcl -lpthread \
	-Wl,-rpath,'$ORIGIN/.' -o "$linuxTarget/libJ"$wrapLibName".so" \
	-Wl,--as-needed -Wl,--no-undefined -Wl,--no-allow-shlib-undefined
}

run_bash run $@

