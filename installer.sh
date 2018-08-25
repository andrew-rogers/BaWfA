
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

ENV_DIR="$(bawfa find_appdata_dir)/BaWfA/etc/env.d"
STARTUP_DIR="$(bawfa find_appdata_dir)/BaWfA/etc/startup.d"
ROOT=

install()
{
    local url="https://github.com/andrew-rogers/BaWfA/raw/master/installers/$1.sh"
    local dst_dir="$(bawfa find_appdata_dir)/BaWfA/installers"
    local dst=$(bawfa download "$url" "$dst_dir")
    mkdir -p "$ENV_DIR"
    mkdir -p "$STARTUP_DIR"
    . "$dst"
}

unzip_github_repo()
{
    local repo="$1"
    local url="https://github.com/andrew-rogers/$repo/archive/master.zip"
    local temp_dir=$(bawfa find_appdata_dir)/BaWfA/tmp

    rm -f "$temp_dir/master.zip"
    local dst=$(bawfa download "$url" "$temp_dir")

    ( cd "$temp_dir" && unzip "$dst" )

    mv "$temp_dir/$repo-master" "$(bawfa find_appdata_dir)/$repo"

    # Set the ROOT variable to point to base on install location.
    ROOT="$(bawfa find_appdata_dir)/$REPO"
}
