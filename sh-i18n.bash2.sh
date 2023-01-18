#!/usr/bin/env bash

# ======================================================================
# DO NOT USE! This is a deprecated and security-risk syntax for bash.
# ----------------------------------------------------------------------
# See below
#   en: https://www.gnu.org/software/gettext/manual/html_node/bash.html
#   ja: https://ayatakesi.github.io/gettext/0.19.8.1/html/bash.html
# ======================================================================

set -eu
. ./lib/sh-i18n.sh

export TEXTDOMAIN="sh-i18n"
export TEXTDOMAINDIR="$PWD/locale"

first_name="Koichi" last_name='Nakashima' num=2

echo $"Hello World!"

# The order of arguments cannot be reordered.
printf $"My name is %s %s""\n" "$first_name" "$last_name"

# Plurals must be handled by yourself.
if [ "$num" -eq 1 ]; then
  echo $"I have an orange" "$num"
else
  printf $"I have %d oranges""\n" "$num"
fi
