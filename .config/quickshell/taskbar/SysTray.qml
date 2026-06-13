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
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 12

    Repeater {
        id: sysTray
        model: SystemTray.items

        MouseArea {
            id: trayItem
            property SystemTrayItem item: modelData
            implicitWidth: Config.settings.bar.trayIconSize
            implicitHeight: Config.settings.bar.trayIconSize

            onClicked: event => {
                switch (event.button) {
                case Qt.LeftButton:
                    if (item.hasMenu) {
                        menu.open();
                    }
                    break;
                case Qt.RightButton:
                    if (item.hasMenu) {
                        menu.open();
                    }
                    break;
                }

                event.accepted = true;
            }

            QsMenuAnchor {
                id: menu

                menu: trayItem.item.menu
                anchor.window: taskbar

                anchor.rect.x: taskbar.width - (sysTrayRow.width + clockWidget.width - trayItem.x)
                anchor.rect.y: taskbar.height - 10

                anchor.rect.height: trayItem.height
                anchor.edges: Edges.Bottom
            }

            IconImage {
                id: trayIcon
                source: trayItem.item.icon
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                visible: false
            }
            Loader {
                anchors.fill: trayIcon
                sourceComponent: MultiEffect {
                    source: trayIcon
                    saturation: Config.settings.bar.monochromeTrayIcons ? -1.0 : 0
                    contrast: Config.settings.bar.monochromeTrayIcons ? 0.7 : 0.0
                    opacity: mouse.hovered || menu.visible ? 1 : 0.7
                    blurEnabled: false
                    shadowEnabled: true

                    shadowBlur: 0
                    blurMax: 1
                    shadowScale: 1
                    shadowVerticalOffset: 1
                    shadowHorizontalOffset: 1
                    shadowOpacity: 1
                    shadowColor: "black"
                }
            }
            HoverHandler {
                id: mouse
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
    Row {
        id: widgetRoot

        spacing: 10

        Widget {
            id: cpuAtom
            value: CPU.value
            icon: CPU.icon
            currentTextColor: CPU.num > 79 ? Config.colors.urgent : Config.colors.text
            currentIconColor: CPU.num > 79 ? Config.colors.urgent : Config.colors.text
        }
        Widget {
            id: memoryAtom
            value: Memory.value
            icon: Memory.icon
            currentTextColor: Memory.num > 79 ? Config.colors.urgent : Config.colors.text
            currentIconColor: Memory.num > 79 ? Config.colors.urgent : Config.colors.text
        }
        Widget {
            id: wifyAtom
            value: Wifi.value
            icon: changeIcon()
            currentTextColor: Wifi.num < 20 ? Config.colors.urgent : Config.colors.text
            currentIconColor: Wifi.num < 20 ? Config.colors.urgent : Config.colors.text

            function changeIcon() {
                const currentVal = Wifi.num

                if (currentVal == -1) {
                    return Wifi.wifi_off
                }

                if (currentVal == -2) {
                    return Wifi.no_wifi
                }

                if (currentVal > 80) {
                    return Wifi.wifi_4
                }

                if (currentVal > 50) {
                    return Wifi.wifi_3
                }

                if (currentVal > 30) {
                    return Wifi.wifi_2
                }

                if (currentVal > 20) {
                    return Wifi.wifi_1
                }

                if (currentVal > 5) {
                    return Wifi.wifi_0
                }

                return Wifi.wifi_off
            }
        }
        Widget {
            id: brightnessAtom
            value: Brightness.value
            icon: Brightness.icon
        }
        Widget {
            id: volumeAtom
            value: Volume.value
            icon: Volume.num <= 0 ? Volume.mutted :Volume.icon
            currentTextColor: Volume.num < 0 ? Config.colors.urgent : Config.colors.text
            currentIconColor: Volume.num <= 0 ? Config.colors.urgent : Config.colors.text
        }
        Widget {
            id: batteryAtom
            value: Battery.value
            icon: getIcon()
            currentTextColor: Battery.num <= 20 && !Battery.charging ? Config.colors.urgent : Config.colors.text
            currentIconColor: Battery.num <= 20 && !Battery.charging ? Config.colors.urgent : Config.colors.text

            function getIcon() {
                const currentBattery = Battery.num

                if (Battery.charging) {
                    return Battery.battery_charging
                }

                if (currentBattery > 80) {
                    return Battery.battery_0
                }

                if (currentBattery > 50) {
                    return Battery.battery_1
                }

                if (currentBattery > 35) {
                    return Battery.battery_2
                }

                if (currentBattery > 20) {
                    return Battery.battery_3
                }

                if (currentBattery > 0) {
                    return Battery.battery_4
                }

                return ""
            }
        }
    }
}
