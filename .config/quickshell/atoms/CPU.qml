pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import ".."

Singleton {
    id: root

    property int num: 0
    property string value: ""
    property string icon: "\uf4bc"

    Process {
        id: proc

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/cpu_usage.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim().split(":")
                root.num = output[0]
                root.value = output[1]
            }
        }

        onExited: {
            poll.restart()
        }
    }

    Timer {
        id: poll

        interval: 1000
        repeat: false

        onTriggered: {
            proc.running = true
        }
    }

    Component.onCompleted: {
        proc.running = true
    }
}
