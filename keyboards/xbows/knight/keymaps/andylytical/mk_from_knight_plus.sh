#!/usr/bin/bash

YES=0
NO=1

VERBOSE=$NO
DEBUG=$NO
COMPILE=$YES
CLEANUP=$NO

PRG=$( basename "$0" )
QMK_USERSPACE=/home/aloftus/working/personal/qmk_userspace
KEYMAP=andylytical
KNIGHT_PLUS_DIR="${QMK_USERSPACE}"/keyboards/xbows/knight_plus/keymaps/"${KEYMAP}"
KNIGHT_PLUS_JSON="${KNIGHT_PLUS_DIR}"/"${KEYMAP}"_knight_plus.json
JSON="${KEYMAP}"_knight.json


mk_keymap_json() {
  [[ $DEBUG -eq $YES ]] && set -x
  sed -e 's/knight_plus/knight/g' "${KNIGHT_PLUS_JSON}" >"${JSON}"
}


copy_files() {
  [[ $DEBUG -eq $YES ]] && set -x
  cp -t . \
    "${KNIGHT_PLUS_DIR}"/*.h \
    "${KNIGHT_PLUS_DIR}"/*.c \
    "${KNIGHT_PLUS_DIR}"/*.mk \
    "${KNIGHT_PLUS_DIR}"/mk_keymap.sh
}


do_compile() {
  [[ $DEBUG -eq $YES ]] && set -x
  local _options
  [[ $VERBOSE -eq $YES ]] && _options+=( '-v' )
  [[ $DEBUG -eq $YES ]] && _options+=( '-d' )
  [[ $COMPILE -eq $NO ]] && _options+=( '-n' )
  [[ $CLEANUP -eq $YES ]] && _options+=( '-c' )
  ./mk_keymap.sh "${_options[@]}"
}


clean_local() {
  # clean up files copied from knight_plus
  [[ $DEBUG -eq $YES ]] && set -x
  ls *.c *.h *.sh *.json | grep -v -E "keymap.c|config.h|rules.mk|${PRG}" \
  | xargs -r rm 
}


print_usage() {
  echo "${PRG} - copy setup from knight_plus and compile"
  echo "SYNOPSIS: ${PRG} [options]"
  echo "OPTIONS:"
  echo "  -h|--help       Print this help message"
  echo "  -v|--verbose    Show 'info' messages"
  echo "  -d|--debug      Show 'debug' messages"
  echo "  -n|--nocompile  Skip the compile step"
  echo "  -k|--keep       Keep intermediate files"
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
    -k|--keep) CLEANUP=$NO;;
    --) ENDWHILE=1;;
    -*) echo "Invalid option '$1'"; exit 1;;
     *) ENDWHILE=1; break;;
  esac
  shift
done

[[ $DEBUG -eq $YES ]] && set -x

mk_keymap_json

copy_files

do_compile

clean_local
