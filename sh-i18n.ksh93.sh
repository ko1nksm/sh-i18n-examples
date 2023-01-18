#!/usr/bin/env ksh

# ======================================================================
# Recommended not to use. This is an out-of-date syntax for ksh93.
# ----------------------------------------------------------------------
# See below
#   https://blog.fpmurphy.com/2010/07/localizing-korn-shell-scripts.html
# ======================================================================

set -eu
. ./lib/sh-i18n.sh

export NLSPATH=locale/sh-i18n.%l.cat

first_name="Koichi" last_name='Nakashima' num=2

echo $"Hello World!"

# The order of arguments cannot be reordered.
printf $"My name is %s %s""\n" "$first_name" "$last_name"

# Plurals must be handled by yourself.
if [ "$num" -eq 1 ]; then
  echo $"I have a pen" "$num"
else
  printf $"I have %d pens""\n" "$num"
fi
