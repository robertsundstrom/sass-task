#!/usr/bin/env bash

set -eu

CYAN='\033[0;36m'
NC='\033[0m'

__exec() {
    local cmd=${1:0}
    shift
    echo -e "${CYAN} > $cmd $@${NC}"
    $cmd $@
}

rm -r artifacts/ || true
rm -r sample/obj/ || true
rm -r src/SassTask.Compiler/obj/ || true
rm -r src/SassTask/obj/ || true

__exec dotnet restore ./src/SassTask.Compiler/
__exec dotnet pack -c Release ./src/SassTask.Compiler/
__exec dotnet restore ./src/SassTask/
__exec dotnet pack -c Release ./src/SassTask/
__exec dotnet restore ./sample/
__exec dotnet build ./sample/
# __exec dotnet msbuild /nologo '/t:Sass' ./sample/
