#!/bin/bash

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

git pull --recurse-submodules
git submodule sync --recursive
git submodule update --init --recursive

