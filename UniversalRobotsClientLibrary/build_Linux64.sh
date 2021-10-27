#!/bin/bash

scriptPath="$(realpath -s "${BASH_SOURCE[0]}")"
scriptDir="$(dirname "$scriptPath")"
cd "$scriptDir"

source "./_bash_config.sh"

run() {
    local -r currentBuild="$currentTmp/build"
    rm -rdf $currentBuild
    mkdir $currentBuild
    
    local -r currentInstall="$(realpath "$currentTarget")"
    rm -rdf $currentInstall
    mkdir $currentInstall

    cd $currentBuild
    cmake -DCMAKE_INSTALL_PREFIX="$currentInstall" $scriptDir/Universal_Robots_Client_Library
    make --jobs="$((2*$(nproc)))"
    make install
    cd "$scriptDir"
}

run_bash run $@

