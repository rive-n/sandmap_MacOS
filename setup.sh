#!/usr/bin/env bash


gnu_version=$(ls /usr/local/Cellar/gnu-getopt 2>/dev/null)

if [ $? -ne 0 ] 
then
	no_verison=$(ls /opt/homebrew/opt/gnu-getopt/bin 2>/dev/null)
	if [ $? -ne 0 ]
	then
		echo "Seems like brew did not complete the installation. Please, make sure to execute: brew install -q gnu-getopt"
		exit
	else
		echo "Using 'ln' to symlink GNU getopt to getopt_gnu (/usr/local/bin/getopt_gnu)"
		ln /opt/homebrew/opt/gnu-getopt/bin/getopt '/usr/local/bin/getopt_gnu'
	fi
else
	echo "Using 'ln' to symlink GNU getopt to getopt_gnu (/usr/local/bin/getopt_gnu)"
	ln "/usr/local/Cellar/gnu-getopt/$gnu_version/bin/getopt" '/usr/local/bin/getopt_gnu'
fi

coreutils=$(ls /usr/local/opt/coreutils 2>/dev/null)
if [ $? -ne 0 ] 
then
	coreutils_brew=$(ls /opt/homebrew/Cellar/coreutils/ 2>/dev/null)
	if [ $? -ne 0 ]
	then
		echo "Seems like brew did not complete the installation. Please, make sure to execute: brew install -q coreutils"
		exit
	fi
fi


readonly _dir="$(dirname "$(greadlink -f "$0")")"

# shellcheck disable=SC2034
_arg="$1"

if [[ "$1" == "install" ]] ; then

  printf "%s\\n" "Create symbolic link to /usr/local/bin"

  if [[ -e "${_dir}/bin/sandmap" ]] ; then

    if [[ ! -e "/usr/local/bin/sandmap" ]] ; then

      ln -s "${_dir}/bin/sandmap" /usr/local/bin

    fi

  fi

  printf "%s\\n" "Create man page to /usr/local/man/man8"

  if [[ -e "${_dir}/static/man8/sandmap.8" ]] ; then

    if [[ ! -e "/usr/local/man/man8/sandmap.8.gz" ]] ; then

      mkdir -p /usr/local/man/man8
      cp "${_dir}/static/man8/sandmap.8" /usr/local/man/man8
      gzip /usr/local/man/man8/sandmap.8

    fi

  fi

elif [[ "$1" == "uninstall" ]] ; then

  printf "%s\\n" "Remove symbolic link from /usr/local/bin"

  if [[ -L "/usr/local/bin/sandmap" ]] ; then

    unlink /usr/local/bin/sandmap

  fi

  printf "%s\\n" "Remove man page from /usr/local/man/man8"

  if [[ -e "/usr/local/man/man8/sandmap.8.gz" ]] ; then

    rm /usr/local/man/man8/sandmap.8.gz

  fi

fi

exit 0
