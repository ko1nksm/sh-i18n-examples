# sh-i18n-examples

sh, bash, ksh i18n (gettext, catgets) examples.

## Examples

The included message catalog (`sh-i18n.mo`, `sh-i18n.C.cat`, `sh-i18n.ja.cat`) are not portable. If it doesn't work, regenerate it using `./re-generate-messages.sh`.

<details>
<summary>Output</summary>

```console
$ LANG=C dash sh-i18n.gnu.sh
Hello World!
My name is Koichi Nakashima
I have 2 oranges

$ LANG=ja_JP.UTF-8 dash sh-i18n.gnu.sh
こんにちは世界！
クォートなしの\\はバックスラッシュを意味します
クォートなしの\はバックスラッシュを意味します
クォートなしの\\はバックスラッシュを意味します
私の名前は Koichi Nakashima です
私の名前は Nakashima Koichi です
私はペンを2本持っています
私はリンゴを%d個持っています
\tはタブです
        はタブです
\tはタブです
\tはタブです
\tはタブです

$ LANG=ja_JP.UTF-8 ksh sh-i18n.posix.sh
こんにちは世界！
クォートなしの\\はバックスラッシュを意味します
クォートなしの\\はバックスラッシュを意味します
クォートなしの\\はバックスラッシュを意味します
私の名前は Koichi Nakashima です
私はペンを2本持っています
\tはタブです
\tはタブです
        はタブです
        はタブです
\tはタブです
\tはタブです

$ LANG=ja_JP.UTF-8 ksh sh-i18n.ksh93.sh
こんにちは世界！
私の名前は Koichi Nakashima です
私はペンを 2 本持っています
```

</details>

### sh-i18n.gnu.sh

This is currently the most common method. GNU gettext is required. Probably works with all POSIX sh. 

### sh-i18n.posix.sh

This method can be used on systems that are fully compliant with POSIX.1-2023 (Issue 8). Use the `gettext`, `ngettext` and `n$` format of `printf` standardized in POSIX.1-2023.

Currently works with ksh93 and zsh. It does not yet work with dash and bash.

### sh-i18n.bash2.sh (out of date)

This method was used in the bash 2.x days. It still works but is deprecated for security reasons.

### sh-i18n.ksh93.sh (out of date)

It works only with ksh93. Use the outdated catgets API instead of gettext API.

## Supplementary library

`lib/sh-i18n.sh` is an auxiliary library to solve some portability and compatibility issues. It is not required, but it is useful.
