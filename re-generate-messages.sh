#!/bin/sh
set -eu
name="sh-i18n"

run() {
  echo + "$@" >&2
  "$@"
}

# For gettext
if type msgfmt >/dev/null 2>&1; then
  for src in ./messages/*.po; do
    locale=${src##*/} && locale=${locale%.*}
    dest="./locale/${locale}/LC_MESSAGES/$name.mo"
    mkdir -p "${dest%/*}"
    run msgfmt -o "$dest" "$src"
  done
else
  echo "msgfmt not found" >&2
fi

# For catgets
if type gencat >/dev/null 2>&1; then
  for src in ./messages/*.msg; do
    locale=${src##*/} && locale=${locale%.*}
    dest="./locale/${name}.${locale}.cat"
    mkdir -p "${dest%/*}"
    [ -f "$dest" ] && rm "$dest"
    run gencat "$dest" "$src"
  done
else
  echo "gencat not found" >&2
fi

