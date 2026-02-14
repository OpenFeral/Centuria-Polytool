
#!/bin/bash

#
# Interpreter
# 

function setup() {
    # Set up
    LOCALPROJECT="$(readlink -f "$PWD")"
    BASEPROJECT="$(readlink -f "$PWD")"
    ROOTPROJECT="$(readlink -f "$PWD")"
    BUILDDIR="$(readlink -f "$PWD")/build"
    BASEBUILDDIR="$(readlink -f "$PWD")/build"
    ROOTBUILDDIR="$(readlink -f "$PWD")/build"
    declare -Ag GLOBALPROPERTIES=()
    declare -Ag LOCALPROPERTIES=()
    preparePolyFileEnvironment
}

function emitvars() {
    # Variable emitter
    pushVariable "id" "$id"
    pushVariable "version" "$version"
    pushVariable "group" "$group"
    pushVariable "name" "$name"
    pushVariable "tasksdir" "$tasksdir"
    pushVariable "dependenciesdir" "$dependenciesdir"
    pushVariable "localoverloadsdir" "$localoverloadsdir"
    pushVariable "builddir" "$builddir"
    for path in "${dependencyProjectPaths[@]}" ; do
        pushArrayElement dependencyProjectPaths "$path"
    done
    for path in "${subProjectPaths[@]}" ; do
        pushArrayElement subProjectPaths "$path"
    done
    for key in "${!GLOBALPROPERTIES[@]}"; do
        pushVariable "globalproperties.$key" "${GLOBALPROPERTIES["$key"]}"
    done
    for key in "${!LOCALPROPERTIES[@]}"; do
        pushVariable "localproperties.$key" "${LOCALPROPERTIES["$key"]}"
    done
}

#
# PolyFile Implementation
#

function addSubProject() {
    path="$1"
    if [ "$path" == "" ]; then
        1>&2 echo "Error: missing argument 'path' in addSubProject statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    subProjectPaths+=("$path")
}

function addDependencyProject() {
    path="$1"
    if [ "$path" == "" ]; then
        1>&2 echo "Error: missing argument 'path' in addDependencyProject statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    dependencyProjectPaths+=("$path")
}

function setGlobal() {
    key="$1"
    value="$2" 
    if [ "$key" == "" ]; then
        1>&2 echo "Error: missing argument 'key' in setGlobal statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    if [ "$value" == "" ]; then
        1>&2 echo "Error: missing argument 'value' in setGlobal statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    GLOBALPROPERTIES+=(["$key"]="$value")
}

function setGlobalIfAbsent() {
    key="$1"
    value="$2" 
    if [ "$key" == "" ]; then
        1>&2 echo "Error: missing argument 'key' in setGlobalIfAbsent statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    if [ "$value" == "" ]; then
        1>&2 echo "Error: missing argument 'value' in setGlobalIfAbsent statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    if [ "${GLOBALPROPERTIES["$key"]}" == "" ]; then
        GLOBALPROPERTIES+=(["$key"]="$value")
    fi
}

function setLocal() {
    key="$1"
    value="$2" 
    if [ "$key" == "" ]; then
        1>&2 echo "Error: missing argument 'key' in setLocal statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    if [ "$value" == "" ]; then
        1>&2 echo "Error: missing argument 'value' in setLocal statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    LOCALPROPERTIES+=(["$key"]="$value")
}

function setLocalIfAbsent() {
    key="$1"
    value="$2" 
    if [ "$key" == "" ]; then
        1>&2 echo "Error: missing argument 'key' in setLocalIfAbsent statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    if [ "$value" == "" ]; then
        1>&2 echo "Error: missing argument 'value' in setLocalIfAbsent statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    if [ "${LOCALPROPERTIES["$key"]}" == "" ]; then
        LOCALPROPERTIES+=(["$key"]="$value")
    fi
}

function setGlobal() {
    key="$1"
    value="$2" 
    if [ "$key" == "" ]; then
        1>&2 echo "Error: missing argument 'key' in setGlobal statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    if [ "$value" == "" ]; then
        1>&2 echo "Error: missing argument 'value' in setGlobal statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    GLOBALPROPERTIES+=(["$key"]="$value")
}

function setGlobalIfAbsent() {
    key="$1"
    value="$2" 
    if [ "$key" == "" ]; then
        1>&2 echo "Error: missing argument 'key' in setGlobalIfAbsent statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    if [ "$value" == "" ]; then
        1>&2 echo "Error: missing argument 'value' in setGlobalIfAbsent statement in polyfile"
        printStackTrace 1
        exit 1
    fi
    if [ "${GLOBALPROPERTIES["$key"]}" == "" ]; then
        GLOBALPROPERTIES+=(["$key"]="$value")
    fi
}

function preparePolyFileEnvironment() {
    id="undefined"
    version="undefined"
    group="undefined"
    name="undefined"
    tasksdir="tasks"
    dependenciesdir="dependencies"
    localoverloadsdir="polylocal"
    builddir="build"
    dependencyProjectPaths=()
    subProjectPaths=()
}
