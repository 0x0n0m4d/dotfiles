pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import ".."

Singleton {
    id: root

    property int num: 0
    property string value: ""
    property bool charging: false

    property string battery_charging: "\uf1e6"
    property string battery_0: "\uf240"
    property string battery_1: "\uf241"
    property string battery_2: "\uf242"
    property string battery_3: "\uf243"
    property string battery_4: "\uf244"

    Process {
        id: proc

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/battery.sh"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim().split(":")
                root.charging = output[0] == "Charging"
                root.num = output[1]
                root.value = output[2]
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
