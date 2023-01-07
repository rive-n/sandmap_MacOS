#!/usr/bin/env bash

echo "Trying to install gnu-getopt and coreutils (we need GNU tools for sandmap)."
brew install -q --overwrite gnu-getopt
# brew link --force gnu-getopt - not recommended, but you can try.
brew install -q --overwrite coreutils

sudo ./setup.sh install
