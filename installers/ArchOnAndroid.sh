
#    BaWfA - Installer for ArchOnAndroid
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

REPO="ArchOnAndroid"

unzip_github_repo "$REPO"

# Create env file
(cd "$ENV_DIR" && ln -s "$ROOT/etc/aoa-settings.sh")

# Create startup file
echo "export AOA_DIR=\"$ROOT\"" > "$STARTUP_DIR/$REPO.sh"
echo ". \"\$AOA_DIR/utils/aoa-startup.sh\"" >> "$STARTUP_DIR/$REPO.sh"

