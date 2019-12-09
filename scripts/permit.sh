#!/usr/bin/env bash
if [ $# -lt 1 ]
  then
    echo "Usage: permit.sh <optional switches> <reference permissions file> <target files>"
    exit 1
fi

OPTS=""
if [ $# -gt 0 ]
  then
    echo "checking $1"
    if [[ "$1" == "-r" ]]; then
      echo "recursive"
      OPTS="-R"
      shift 1
    fi
fi

GOOD_FILE=$1

# remaining args should be list of files
shift 1
BAD_FILES=$@

echo copying permissions from $GOOD_FILE to $BAD_FILES
chown $OPTS --reference $GOOD_FILE $BAD_FILES
chgrp $OPTS --reference $GOOD_FILE $BAD_FILES
chmod $OPTS --reference $GOOD_FILE $BAD_FILES
