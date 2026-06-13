pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int num: 0
    property string value: ""

    property string no_wifi: "\uf00d"
    property string wifi_off: "\udb82\udd2d"
    property string wifi_0: "\udb82\udd2f"
    property string wifi_1: "\udb82\udd1f"
    property string wifi_2: "\udb82\udd22"
    property string wifi_3: "\udb82\udd25"
    property string wifi_4: "\udb82\udd28"

    Process {
        id: proc

        command: ["sh", "-c", "/home/n0m4d/.config/scripts/wifi.sh"]

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
