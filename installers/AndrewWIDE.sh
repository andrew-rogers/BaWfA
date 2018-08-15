
#    BaWfA - Installer for AndrewWIDE
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

URL=https://github.com/andrew-rogers/AndrewWIDE/archive/master.zip
TEMP_DIR=$(bawfa find_appdata_dir)/BaWfA/tmp

DST=$(bawfa download "$URL" "$TEMP_DIR")

( cd "$TEMP_DIR" && unzip "$DST" )

mv "$TEMP_DIR/AndrewWIDE-master" "$(bawfa find_appdata_dir)/AndrewWIDE"

