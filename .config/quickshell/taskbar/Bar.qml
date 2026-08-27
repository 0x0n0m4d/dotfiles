import Quickshell
import Quickshell.Io
import QtQuick

import ".."

Scope {
    Variants {
        model: Quickshell.screens
        Item {
            id: root
            required property var modelData

            PanelWindow {
                id: taskbar
                screen: root.modelData

                anchors {
                    bottom: true
                    left: true
                    right: true
                }
                implicitHeight: 20
                color: Config.colors.base

                Item {
                    id: sysTrayWidget
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    height: parent.height
                    width: sysTray.width + 18
                    SysTray {
                        id: sysTray
                    }
                }

                Item {
                    id: workspacesObject
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    height: parent.height
                    Workspaces {
                        id: workspaces
                    }
                }
            }
        }
    }
}
