
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

check_busybox()
{
    busybox_install
}

second_stage_check()
{
    echo "Not yet implemented!"
}

cmd=$1
shift

. "$BAWFA_SETUP" "no_init"

# Include Busybox setup functions
. "$(bawfa get_script busybox-setup.sh)"

if [ -n "$cmd" ]; then
    $cmd $*
else
    second_stage_check
fi
