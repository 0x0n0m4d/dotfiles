pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string value: ""

    Process {
        id: proc

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/wifi.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim()
                root.value = /^-?\d+$/.test(output)
                    ? "WiFi:"+output+"%"
                    ? "WiFi:"+output
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
