#!/bin/bash
# Package dist/FlatCAM (PyInstaller output) for Linux x86_64:
#   dist/FlatCAM-<version>-Linux-x86_64.AppImage  (single runnable file)
#   dist/FlatCAM-<version>-Linux-x86_64.tar.gz    (plain folder, fallback without FUSE)
# Usage (from repo root, after pyinstaller): packaging/make_linux.sh
set -e
VERSION=8.4-py3
NAME=FlatCAM-$VERSION-Linux-x86_64
APPDIR=build/FlatCAM.AppDir

# tar.gz
tar -C dist -czf "dist/$NAME.tar.gz" FlatCAM

# AppDir
rm -rf "$APPDIR"
mkdir -p "$APPDIR/usr/lib"
cp -R dist/FlatCAM "$APPDIR/usr/bin"

# GLU is not part of every desktop install; bundle it for polygon tessellation
GLU=$(ldconfig -p | awk '/libGLU\.so\.1 /{print $NF; exit}')
if [ -n "$GLU" ]; then cp -L "$GLU" "$APPDIR/usr/lib/"; fi

cp share/flatcam_icon256.png "$APPDIR/flatcam.png"
cat > "$APPDIR/flatcam.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=FlatCAM
Comment=2D Computer-Aided PCB Manufacturing (Gerber to G-code)
Exec=FlatCAM
Icon=flatcam
Categories=Engineering;Electronics;
Terminal=false
EOF
cat > "$APPDIR/AppRun" <<'EOF'
#!/bin/sh
HERE="$(dirname "$(readlink -f "$0")")"
export LD_LIBRARY_PATH="$HERE/usr/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
exec "$HERE/usr/bin/FlatCAM" "$@"
EOF
chmod +x "$APPDIR/AppRun"

TOOL=build/appimagetool
if [ ! -x "$TOOL" ]; then
    curl -fsSL -o "$TOOL" https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage
    chmod +x "$TOOL"
fi
ARCH=x86_64 "$TOOL" --appimage-extract-and-run "$APPDIR" "dist/$NAME.AppImage"
