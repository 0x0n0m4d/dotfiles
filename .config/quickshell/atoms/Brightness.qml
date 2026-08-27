pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string value: ""

    Process {
        id: proc

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/brightness.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.value = "Bright:"+text.trim()+"%"
            }
        }
    }

    function refresh() {
        proc.running = true
    }

    Component.onCompleted: {
        refresh()
    }
}
