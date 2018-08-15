
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

bd_getscripts()
{
    bd_getscript bawfa-setup.sh
    bd_getscript busybox-setup.sh
    bd_getscript second-stage.sh
    bd_getscript installer.sh
}

bd_getscript()
{
    if [ -z "$1" ]; then
        bd_getscripts
    else
        local src="/sdcard/Download/$1"
        local dst="$(bawfa find_appdata_dir)/BaWfA/utils/$1"
        [ -e "$src" ] && cat "$src" > "$dst"
    fi
}

