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

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/time.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.value = text.trim()
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
