pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import ".."

Singleton {
    id: root

    property string value: ""

    Process {
        id: proc

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/volume.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim()
                root.value = /^-?\d+$/.test(output)
                    ? "Vol:"+output+"%"
                    : "Vol:"+output
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
