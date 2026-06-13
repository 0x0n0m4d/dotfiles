import QtQuick
import Quickshell
import Quickshell.Io

import "taskbar" as Taskbar
import "popups" as Popups
import "atoms" as Atoms

Scope {
    id: root
    FontLoader {
        id: iconFont
        source: "fonts/JetBrainsMonoNerdFont-Regular.ttf"
    }
    FontLoader {
        id: textFont
        source: "fonts/SarasaGothicJ-Regular.ttf"
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
