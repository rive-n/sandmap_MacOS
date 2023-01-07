#!/usr/bin/env bash

echo "Trying to install gnu-getopt and coreutils (we need GNU tools for sandmap)."
brew install -q gnu-getopt
# brew link --force gnu-getopt - not recommended, but you can try.
brew install -q coreutils

# sudo ./setup.sh install
