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

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/battery.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim().split(":")
                const charging = output[0] == 1
                root.blink = output[1] <= 40 && output[0] != 1
                root.value =  charging
                    ? "Bat:+"+output[1]+"%"
                    : "Bat:"+output[1]+"%"
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
