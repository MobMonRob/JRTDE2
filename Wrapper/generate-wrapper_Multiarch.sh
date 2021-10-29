#!/bin/bash

scriptPath="$(realpath -s "${BASH_SOURCE[0]}")"
scriptDir="$(dirname "$scriptPath")"
cd "$scriptDir"

source "./_bash_config.sh"

run() {
    local -r swigJavaOutDir="$currentTarget/java/de/dhbw/rahmlab/"$wrapLibName"/impl"

    local -r wrapLibTarget="$wrapLibDir/$currentTarget"
	local -r wrapLibInclude="$wrapLibTarget/include"

	mkdir -p "$swigJavaOutDir"
	mkdir -p "$currentTmp"

	#-debug-tmsearch
	swig -doxygen -Wall -Wextra -c++ -java -package "de.dhbw.rahmlab."$wrapLibName".impl" -outdir "$swigJavaOutDir" -o "$currentTmp/"$wrapLibName"_wrap.cpp" -I"$wrapLibInclude" ./PlatformIndependent.i
}

run_bash run $@

