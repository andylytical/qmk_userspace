#!/usr/bin/bash

KEYMAP=keymap.c
HEADER=keymap.h

YES=0
NO=1

VERBOSE=$YES
DEBUG=$YES

# ANSI escape codes for colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'  # No Color

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
  rm -qf "${KEYMAP}" "${HEADER}"
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
  cat *.h >"${HEADER}"
}



###
# MAIN
###

[[ $DEBUG -eq $YES ]] && set -x

init

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

[[ -f "${KEYMAP}" ]] && qmk compile
