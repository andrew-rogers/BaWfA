
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

# Specify busybox URLs
BB_URLS="https://github.com/windflyer/android_binaries/raw/master/busybox-armv7l
https://busybox.net/downloads/binaries/1.26.2-defconfig-multiarch/busybox-armv6l"

# Specify the busybox filename when installed
BB=busybox

# Binaries directory
BIN_DIR="$(bawfa find_appdata_dir)/BaWfA/bin"

check_busybox()
{
  if [ -x "$BIN_DIR/$BB" ]; then
    "$BIN_DIR/true" 2> /dev/null && echo "BusyBox is installed in $BIN_DIR" >&2 && echo "$BIN_DIR/$BB" && return 0
  fi
  busybox_install
}

busybox_install()
{
  local bb="$BIN_DIR/$BB"
  if [ -e "$bb" ]
  then
    chmod 755 "$bb"
  else

    # Not in $BIN_DIR/$BB so download
    local bb_dl=$(busybox_download)

    [ ! -f "$bb_dl" ] && echo "Can't find: $BB" >&2 && return 1
    echo "Found busybox at: $bb_dl" >&2

    chmod 755 "$bb_dl"
    "$bb_dl" mv "$bb_dl" "$BIN_DIR/$BB"
  fi

  busybox_symlinks
}

busybox_download()
{
  local bb
  echo "$BB_URLS" | while read -r bb
  do
    local bb_dl=$(bawfa download $bb $BIN_DIR)
    [ -n "$bb_dl" ] && echo "$bb_dl" && break
  done
}

busybox_symlinks() {
  echo "Making symlinks for busybox applets, could take a while." >&2
  for app in $($BIN_DIR/$BB --list)
  do
    # Create links for all apps except wget, the busybox wget doesn't work on android.
    if [ "$app" != "wget" ]; then
      busybox_symlink "$app"
    fi
  done
}

busybox_symlink() {
  if [ ! -e "$BIN_DIR/$1" ]; then
    ( cd "$BIN_DIR" && $BIN_DIR/$BB ln -s $BB $1 )
  fi
}

