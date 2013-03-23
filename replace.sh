#!/bin/sh

# Use cases:
#   TEST: ./replace.sh 'old' 'new' -i
#   LIVE: ./replace.sh 'old' 'new'
#
# Examples:
#
#
#

for file in `find . -type f -name '*' | grep -v "$0"`
do
  echo "*** IN $file"
  sed $3 "s/$1/$2/g" $file | grep -n -A1 -B1 $2
done
