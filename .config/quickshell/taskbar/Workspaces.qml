import Quickshell
import Quickshell.I3
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

import ".."

RowLayout {
    id: workspaces

    spacing: 3
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter

    property var currentWorkspaces:
        I3.workspaces.values.filter(
            w => w.monitor.name == taskbar.screen.name
        )

    property int focusedWorkspace:
        I3.focusedWorkspace.number

    Repeater {
        model: parent.currentWorkspaces

        Button {
            id: control

            anchors.centerIn: parent.centerIn

            contentItem: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: modelData.name.replace(/^[0-9]+:/, "")

                font.family: textFont.name
                font.pixelSize: Config.settings.bar.fontSize

                width: 10
                height: 10

                color:
                    modelData.urgent
                        ? Config.colors.urgentText
                        : modelData.number === workspaces.focusedWorkspace
                            ? Config.colors.workspaceFocusedText
                            : Config.colors.text
            }

            onPressed: event => {
                I3.dispatch(`workspace ${modelData.name}`);
                event.accepted = true;
            }

            NewBorder {
                commonBorderWidth: 2
                commonBorder: false

                lBorderwidth: -2
                rBorderwidth: 0
                tBorderwidth: -4
                bBorderwidth: -1

                borderColor: Config.colors.outline
                zValue: -1
            }

            background: Rectangle {
                anchors.centerIn: parent

                width: 22
                height: 22

                border.width: 1
                border.color: Config.colors.outline

                color:
                    modelData.urgent
                        ? Config.colors.urgent
                        : modelData.number === workspaces.focusedWorkspace
                            ? Config.colors.shadow
                            : mouse.hovered
                                ? Config.colors.shadow
                                : Config.colors.base
            }

            HoverHandler {
                id: mouse

                acceptedDevices:
                    PointerDevice.Mouse |
                    PointerDevice.TouchPad

                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}
