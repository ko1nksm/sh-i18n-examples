#!/bin/sh

# ======================================================================
# Use only commands and options standardized in POSIX Issue 8.
# ======================================================================

set -eu
. ./lib/sh-i18n.sh

export TEXTDOMAIN="sh-i18n"
export TEXTDOMAINDIR="${PWD}/locale"

first_name="Koichi" last_name='Nakashima' num=2

gettext 'Hello World!' && echo

# The 'echo' is not very portable. Interpretation of options
# and backslashes varies from shell to shell (dash, bash, etc).
# For portability, it is useful to use 'putln' defined in sh-i18n.sh.
gettext 'The \\ without quotes means backslash' && echo    # Correct
echo "$(gettext 'The \\ without quotes means backslash')"  # Wrong
putln "$(gettext 'The \\ without quotes means backslash')" # Correct

# Use 'My name is %2$s %1$s' to reorder the arguments.
# The new printf format 'n$' was standardized in POSIX Issue 8.
printf "$(gettext 'My name is %s %s')\n" "$first_name" "$last_name"
printf "$(ngettext 'I have a pen' 'I have %d pens' "$num")\n" "$num"

# Note the number of backslashes.
# For portability, It is useful to use 'putfln' defined in sh-i18n.sh.
gettext $'The \\t is a tab' && echo         # Correct
gettext 'The \t is a tab' && echo           # Correct
printf "$(gettext 'The \t is a tab')\n"     # Wrong
printf "$(gettext $'The \\t is a tab')\n"   # Wrong
printf "$(gettext $'The \\\\t is a tab')\n" # Correct
putfln "$(gettext $'The \\t is a tab')"     # Correct

