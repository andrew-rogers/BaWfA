
#    BaWfA - install Busybox and Wget on Android into terminal app
#    Copyright (C) 2018  Andrew Rogers
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

bawfa() {
  # Path for the user downloaded wget
  local WGET_DL="/sdcard/Download/wget-armeabi"

  local cmd=$1
  shift

  case $cmd in

    "find_appdata_dir" | "fad" )
      # --- Find out where Busybox and Wget can be installed ---
      # When deployed on an Android terminal app (eg. connectbot) it is
      # possible that the current directory is not writable. The terminal app's
      # install directory should be writable so we install there. However, we first
      # check if the current directory is writable.
      local here=${PWD%%/BaWfA*}
      if [ -w "$here" ]; then
        # We can write to the current dir so install here.
        echo "$here";
      else
        # Find the directory of the terminal app. The terminal app may only be able 
        # to write to and execute from its directory or sub directory.
        echo "/data/data/$(cat /proc/$PPID/cmdline)/"
      fi
    ;;

    "find_wget" )
      local app_dir=$(bawfa find_appdata_dir)
      local bawfa_dir="$app_dir/BaWfA"
      if [ -e "$bawfa_dir/bin/wget" ]; then
        echo "$bawfa_dir/bin/wget"
      elif [ -e "$app_dir/wget" ]; then
        echo "$app_dir/wget"
      fi
        
    ;;

    "install_wget" )
      local app_dir=$(bawfa find_appdata_dir)
      if [ ! -e "$app_dir/wget" ]; then
        # not in $FILES_DIR/wget so copy from download directory
        [ ! -f "$WGET_DL" ] && echo "Can't find: $WGET_DL" >&2 && return 1
        echo "Found wget at: $WGET_DL" >&2
    
        # Android may not have cp, use cat
        cat "$WGET_DL" > "$app_dir/wget"
      fi
      chmod 755 "$app_dir/wget"
    ;;

    "check_wget" )
      $(bawfa find_wget) --help > /dev/null 2>&1 || bawfa install_wget
      bawfa find_wget
    ;;

    "get_script" )
      local script=$1
      local bawfa_dir="$(bawfa find_appdata_dir)/BaWfA"
      if [ -e "$bawfa_dir/utils/$script" ]; then
        echo "$bawfa_dir/utils/$script"
      else
        local url="https://github.com/andrew-rogers/BaWfA/raw/master/$script"
        $(bawfa find_wget) --no-clobber --no-check-certificate --directory-prefix=$bawfa_dir/utils $url
        if [ -e "$bawfa_dir/utils/$script" ]; then
          echo "$bawfa_dir/utils/$script"
        else
          echo "Failed to download $script" >&2
          return 1
        fi
      fi
    ;;

    "check_busybox" )
      local script="$(bawfa get_script busybox-setup.sh)"
      if [ -e "$script" ]; then
        sh -c "BAWFA_DIR=$(bawfa find_appdata_dir)/BaWfA; . $script"
      fi
    ;;

    * )
      echo "unknown command: $cmd" >&2 
  esac
}

if [ ! -d "BAWFA_DIR" ]; then
  bawfa check_wget > /dev/null
  bawfa get_script bawfa-setup.sh
  bawfa check_busybox

  cd "$(bawfa find_appdata_dir)/BaWfA" > /dev/null 2>&1 || cd "$(bawfa find_appdata_dir)"
fi

