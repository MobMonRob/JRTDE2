#!/bin/bash

scriptPath="$(realpath -s "${BASH_SOURCE[0]}")"
scriptDir="$(dirname "$scriptPath")"
cd "$scriptDir"

source "./_bash_config.sh"

run() {
    cd ./Universal_Robots_Client_Library
    rm -rdf build
    mkdir build
    cd build
    cmake ..
    make
    #--jobs="$((2*$(nproc)))"

    cd "$scriptDir"
}

run_bash run $@

