#!/usr/bin/bash

PRG=$( basename "$0" )

YES=0
NO=1

VERBOSE=$NO
DEBUG=$NO
COMPILE=$YES

# ANSI escape codes for colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'  # No Color

KEYMAP=keymap.c
HEADER=keymap.h

err() {
  echo -e "${RED}✗ ERROR: $*${NC}"
}

success() {
  echo -e "${GREEN}✓ $*${NC}"
}

die() {
  err "$*"
  echo "from (${BASH_SOURCE[1]} [${BASH_LINENO[0]}] ${FUNCNAME[1]})"
  kill 0
  exit 99
}

info() {
  [[ $VERBOSE -eq $YES ]] && {
    echo -e "${RED}INFO: ${NC}$*" 1>&2
  }
}

debug() {
  [[ $DEBUG -eq $YES ]] && {
    echo -e "${RED}DEBUG: ${NC}$*" 1>&2
  }
}


init() {
  [[ $DEBUG -eq $YES ]] && set -x
  rm -f "${KEYMAP}" "${HEADER}"
}


get_json() {
  [[ $DEBUG -eq $YES ]] && set -x
  local _qty
  _qty=$( ls *.json | wc -l )
  [[ ${_qty} -ne 1 ]] && die "expected only one json file, found '${_qty}'"
  ls *.json
}


get_keymap_parts() {
  [[ $DEBUG -eq $YES ]] && set -x
  ls *.c
}


mk_header() {
  [[ $DEBUG -eq $YES ]] && set -x
  local _h_files
  set -x
  _h_files=( $( ls *.h | grep -v config.h) )
  for h_file in "${_h_files[@]}"; do
    cat "${h_files[@]}" >>"${HEADER}"
  done
  set +x
}


print_usage() {
  echo "${PRG} - create keymap.h, keymap.c, and compile"
  echo "SYNOPSIS: ${PRG} [options]"
  echo "OPTIONS:"
  echo "  -h|--help       Print this help message"
  echo "  -v|--verbose    Show 'info' messages"
  echo "  -d|--debug      Show 'debug' messages"
  echo "  -n|--nocompile  Skip the compile step"
  echo
}



###
# MAIN
###

ENDWHILE=0
while [[ $# -gt 0 ]] && [[ $ENDWHILE -eq 0 ]] ; do
  case $1 in
    -h|--help) print_usage;;
    -v|--verbose) VERBOSE=$YES;;
    -d|--debug) DEBUG=$YES;;
    -n|--nocompile) COMPILE=$NO;;
    --) ENDWHILE=1;;
    -*) echo "Invalid option '$1'"; exit 1;;
     *) ENDWHILE=1; break;;
  esac
  shift
done

[[ $DEBUG -eq $YES ]] && set -x

init

mk_header

keymap_json=$( get_json )

keymap_parts=( $( get_keymap_parts ) )

mk_header

qmk json2c -o "${KEYMAP}" "${keymap_json}"

for fn in "${keymap_parts[@]}"; do
  cat <<ENDHERE >>"${KEYMAP}"

/* 
 * ${fn}
 */
ENDHERE
  cat "${fn}"  >>"${KEYMAP}"
done

[[ -f "${KEYMAP}" ]] && [[ $COMPILE -eq $YES ]] && qmk compile
