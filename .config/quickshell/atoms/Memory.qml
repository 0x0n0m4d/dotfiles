pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import ".."

Singleton {
    id: root

    property string value: ""
    property bool blink: false

    Process {
        id: proc

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/memory.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim()
                root.blink = output >= 80
                root.value = "Mem:"+output+"%"
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
