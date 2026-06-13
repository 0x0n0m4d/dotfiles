pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string value: ""
    property string icon: "\udb80\udf35"

    Process {
        id: proc

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/brightness.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.value = text.trim()
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
