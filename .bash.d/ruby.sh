#!/usr/bin/env bash
# shellcheck disable=SC2230
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: circa 2012 (forked from .bashrc)
#
#  https://github.com/harisekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# ============================================================================ #
#                              R u b y   /   G e m
# ============================================================================ #

bash_tools="${bash_tools:-$(dirname "${BASH_SOURCE[0]}")/..}"

# shellcheck disable=SC1090
#. "$bash_tools/.bash.d/os_detection.sh"

if ! type add_PATHS &>/dev/null ; then
    . "$bash_tools/.bash.d/paths.sh"
fi

# gems will be installed to ~/.gem/ruby/x.y.z/bin

# RVM stuff
# usually /usr/local/rvm/bin
if [ -n "${rvm_bin_path:-}" ];then
    add_PATH "$rvm_bin_path"
fi
if [ -d /usr/local/rvm/bin ]; then
    add_PATH /usr/local/rvm/bin
fi

# add newest ruby to path first
ruby_bins="$(find ~/.gem/ruby -maxdepth 2 -name bin -type d 2>/dev/null)"
if isMac; then
    ruby_bins_newest="$(tail -r <<< "$ruby_bins")"
else
    ruby_bins_newest="$(tac <<< "$ruby_bins")"
fi
for ruby_bin in $ruby_bins_newest; do
    add_PATH "$ruby_bin"
done
unset ruby_bins
unset ruby_bins_newest

alias lsrubybin='ls -d ~/.gem/ruby/*/bin/* 2>/dev/null'
alias llrubybin='ls -ld ~/.gem/ruby/*/bin/* 2>/dev/null'

# HomeBrew install on Linux (for AWS SAM CLI)
if [ -d ~/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/current/bin ]; then
    add_PATH ~/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/current/bin
fi