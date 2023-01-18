#!/bin/sh

# ======================================================================
# Using GNU gettest.sh. but works with all POSIX shells.
# ----------------------------------------------------------------------
# See below
#   en: https://www.gnu.org/software/gettext/manual/html_node/bash.html
#   ja: https://ayatakesi.github.io/gettext/0.19.8.1/html/bash.html
# ======================================================================

set -eu
. ./lib/sh-i18n.sh

. "gettext.sh"

export TEXTDOMAIN="sh-i18n"
export TEXTDOMAINDIR="${PWD}/locale"

first_name="Koichi" last_name='Nakashima' num=2

gettext 'Hello World!' && echo

# The 'echo' is not very portable. Interpretation of options
# and backslashes varies from shell to shell (dash, bash, etc).
# For portability, It is useful to use 'putln' defined in sh-i18n.sh.
gettext 'The \\ without quotes means backslash' && echo    # Correct
echo "$(gettext 'The \\ without quotes means backslash')"  # Wrong
putln "$(gettext 'The \\ without quotes means backslash')" # Correct

# Use 'My name is ${last_name} ${first_name}' to reorder the arguments.
# The new printf format 'n$' was standardized in POSIX Issue 8.
printf "$(gettext 'My name is %s %s')\n" "$first_name" "$last_name"
eval_gettext 'My name is ${first_name} ${last_name}' && echo
printf "$(ngettext 'I have a pen' 'I have %d pens' "$num")\n" "$num"
eval_ngettext 'I have an apple' 'I have ${num} apples' "$num" && echo

# Note the number of backslashes.
# For portability, It is useful to use 'putfln' defined in sh-i18n.sh.
gettext 'The \t is a tab' && echo        # Correct
echo "$(gettext 'The \t is a tab')"      # Wrong
printf "$(gettext 'The \\t is a tab')\n" # Correct
$echo "$(gettext 'The \t is a tab')"     # Correct
putfln "$(gettext 'The \t is a tab')"    # Correct
