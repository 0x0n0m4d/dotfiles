import QtQuick
import Quickshell
import Quickshell.Io

import "taskbar" as Taskbar
import "atoms" as Atoms

Scope {
    id: root
    FontLoader {
        id: textFont
        source: "fonts/BigBlueTerm437NerdFont-Regular.ttf"
    }
    Taskbar.Bar {}

    IpcHandler {
        target: "Volume"

        function refresh() {
            Atoms.Volume.refresh()
        }
    }
    IpcHandler {
        target: "Brightness"

        function refresh() {
            Atoms.Brightness.refresh()
        }
    }
}
