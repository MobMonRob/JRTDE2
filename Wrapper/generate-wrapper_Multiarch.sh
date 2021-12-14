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

	local -r swigModulesDirectory="$projectDir/SWIG_Modules"
	local -r swigLibDirectory="$projectDir/SWIG_Lib"

	local -r SwigModulesArray=($(find "$swigModulesDirectory"/* -maxdepth 0 -mindepth 0 -type f -printf '%f\n'))

	for swigModule in ${SwigModulesArray[@]}
	do
		if [[ $swigModule != "urcl_data_package_2.i" ]]; then
			continue
		fi

		echo "->$swigModule"

		#-debug-tmused -debug-tmsearch -debug-typemap
		swig -debug-tmused -debug-tmsearch -debug-typemap -doxygen -Wextra -cpperraswarn -DSWIGWORDSIZE64 -c++ -java -package "de.dhbw.rahmlab."$wrapLibName".impl" -outdir "$swigJavaOutDir" -o "$currentTmp/"$swigModule"_wrap.cpp" -I"$wrapLibInclude" -I"$swigLibDirectory" "$swigModulesDirectory/$swigModule"
	done
}

run_bash run $@

