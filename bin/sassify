#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Usage: $0 <substitute-path> <with-path> <css-file>"
  exit 1
fi

from=$1
to=$2
file=$3
out=$file.scss

sed 's#url\s*(.*'$from'\([^)"'\'']*\)["'\'']*)#asset-url("'$to'\1")#g'  $file > $out
