#!/bin/zsh
# Build dist/FlatCAM-<version>-macOS-<arch>.dmg from dist/FlatCAM.app
# Usage (from repo root, after pyinstaller): packaging/make_dmg.sh
set -e
VERSION=8.4-py3
ARCH=$(uname -m)
STAGE=$(mktemp -d)
cp -R dist/FlatCAM.app "$STAGE/"
ln -s /Applications "$STAGE/Applications"
rm -f "dist/FlatCAM-$VERSION-macOS-$ARCH.dmg"
hdiutil create -volname "FlatCAM $VERSION" -srcfolder "$STAGE" -ov -format UDZO \
    "dist/FlatCAM-$VERSION-macOS-$ARCH.dmg"
rm -rf "$STAGE"
