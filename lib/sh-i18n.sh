if (eval ": \"\${PPID//?/}\"") 2>/dev/null; then
  # Not POSIX shell compliant but fast
  replace_all() {
    eval "$1=\${2//\"\$3\"/\"\$4\"}"
  }
else
  # For POSIX Shells
  replace_all() {
    set -- "$1" "$2$3" "$3" "$4" ""
    while [ "$2" ]; do
      set -- "$1" "${2#*"$3"}" "$3" "$4" "$5${2%%"$3"*}$4"
    done
    eval "$1=\${5%\"\$4\"}"
  }
fi

# mksh prinitf is not built-in and slow, use print instead.
# All ksh-based shells implement print.
if [ "${KSH_VERSION:-}" ]; then
  put() {
    IFS=" $IFS" && set -- "$*" && IFS="${IFS# }"
    command print -nr -- "${1:-}"
  }
  putln() {
    IFS=" $IFS" && set -- "$*" && IFS="${IFS# }"
    command print -r -- "${1:-}"
  }
else
  put() {
    IFS=" $IFS" && set -- "$*" && IFS="${IFS# }"
    command printf '%s' "${1:-}"
  }
  putln() {
    IFS=" $IFS" && set -- "$*" && IFS="${IFS# }"
    command printf '%s\n' "${1:-}"
  }
fi


# Equivalent to printf but interprets only % format
# (does not interpret backslash escapes)
putf() {
  putf_arg1=''
  replace_all putf_arg1 "$1" '\' '\\'
  shift
  set -- "$putf_arg1" "$@"
  unset putf_arg1
  printf -- "$@"

}

putfln() {
  putf "$@" && echo
}

# Workaround for non GNU gettext:
#   Some gettext implementations interpret escape sequences by default.
#   POSIX gettext has a -e/-E option, but if neither the -e nor -E
#   option is specified, it is undefined which will be the default.
if gettext -E "" >/dev/null 2>&1; then
  gettext() {
    command gettext -E "$@"
  }
  ngettext() {
    command ngettext -E "$@"
  }
else
  # Unfortunately, Solaris 11 gettext does not have the -E option.
  # Therefore, it escapes on its own.
  gettext() {
    gettext_arg1=''
    replace_all gettext_arg1 "$1" '\' '\\'
    shift
    set -- "$gettext_arg1" "$@"
    unset gettext_arg1
    command gettext -e "$@"
  }
  ngettext() {
    ngettext_arg1='' ngettext_arg2=''
    replace_all ngettext_arg1 "$1" '\' '\\'
    replace_all ngettext_arg2 "$2" '\' '\\'
    shift 2
    set -- "$ngettext_arg1" "$ngettext_arg2" "$@"
    unset ngettext_arg1 ngettext_arg2
    command ngettext -e "$@"
  }
fi

