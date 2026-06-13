pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import ".."

Singleton {
    id: root

    property int num: 0
    property string value: ""

    property string icon: "\uf028"
    property string mutted: "\uf00d"

    Process {
        id: proc

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/volume.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim().split(":")
                root.num = output[0]
                root.value = output[1]
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
