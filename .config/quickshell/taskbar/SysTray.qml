import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import QtQuick.Effects

import "../atoms/"
import ".."

RowLayout {
    id: sysTrayRow
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter

    Row {
        id: widgetRoot

        spacing: 10

        Widget {
            id: timeAtom
            value: Time.value
        }
        Widget {
            id: batteryAtom
            value: Battery.value
            blink: Battery.blink
        }
        Widget {
            id: volumeAtom
            value: Volume.value
        }
        Widget {
            id: brightnessAtom
            value: Brightness.value
        }
        Widget {
            id: wifyAtom
            value: Wifi.value
        }
        Widget {
            id: cpuAtom
            value: CPU.value
            blink: CPU.blink
        }
        Widget {
            id: memoryAtom
            value: Memory.value
            blink: Memory.blink
        }
    }
}
