# PyInstaller spec for FlatCAM 8.4-py3 (macOS .app and Windows folder build).
# Build from the repository root:
#     pyinstaller --noconfirm packaging/FlatCAM.spec
import os
import sys

from PyInstaller.utils.hooks import collect_data_files, collect_submodules

ROOT = os.path.abspath(SPECPATH + '/..')
VERSION = '8.4-py3'

hiddenimports = (
    collect_submodules('tclCommands')
    + collect_submodules('OpenGL', filter=lambda m: not m.startswith(('OpenGL.Tk', 'OpenGL.raw.GLES', 'OpenGL.GLES')))
    + collect_submodules('vispy.app.backends')
    + ['vispy.app.backends._pyqt5', 'tkinter', 'svg.path']
)

datas = (
    [(os.path.join(ROOT, 'share'), 'share')]
    + collect_data_files('vispy')                      # GLSL shaders, fonts
)

a = Analysis(
    [os.path.join(ROOT, 'FlatCAM.py')],
    pathex=[ROOT],
    datas=datas,
    hiddenimports=hiddenimports,
    excludes=['PyQt6', 'PySide2', 'PySide6', 'IPython', 'jupyter', 'notebook', 'pytest',
              'cx_Freeze', 'dill', 'FlatCAM_GTK', 'descartes',
              'scipy', 'matplotlib',                   # only used by tests
              'PyQt5.QtQml', 'PyQt5.QtQuick', 'PyQt5.QtQuickWidgets', 'PyQt5.QtDesigner',
              'PyQt5.QtXmlPatterns', 'PyQt5.QtLocation', 'PyQt5.QtPositioning', 'PyQt5.QtSql',
              'PyQt5.QtWebSockets', 'PyQt5.QtNetwork', 'PyQt5.QtMultimedia', 'PyQt5.QtBluetooth',
              'PyQt5.QtSensors', 'PyQt5.QtSerialPort', 'PyQt5.QtHelp'],  # keep QtTest: needed by VisPy
    noarchive=False,
)

pyz = PYZ(a.pure)

icon = os.path.join(ROOT, 'packaging', 'FlatCAM.icns') if sys.platform == 'darwin' \
    else os.path.join(ROOT, 'share', 'flatcam_icon256.ico')

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='FlatCAM',
    console=False,
    icon=icon,
    upx=False,
)

coll = COLLECT(exe, a.binaries, a.datas, name='FlatCAM', upx=False)

if sys.platform == 'darwin':
    app = BUNDLE(
        coll,
        name='FlatCAM.app',
        icon=icon,
        bundle_identifier='id.ac.sgu.flatcam-py3',
        version=VERSION,
        info_plist={
            'CFBundleName': 'FlatCAM',
            'CFBundleDisplayName': 'FlatCAM',
            'CFBundleShortVersionString': VERSION,
            'NSHighResolutionCapable': True,
            'NSHumanReadableCopyright': '(c) 2014-2015 Juan Pablo Caram; '
                                        'Python 3 port (c) 2026 Purnomo Sejati, Swiss German University',
        },
    )
