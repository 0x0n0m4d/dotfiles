import Quickshell
import Quickshell.I3
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

import ".."

RowLayout {
    id: workspaces

    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter

    property var currentWorkspaces:
        I3.workspaces.values.filter(
            w => w.monitor.name == taskbar.screen.name
        )

    property int focusedWorkspace:
        I3.focusedWorkspace ? I3.focusedWorkspace.number : -1

    Repeater {
        model: parent.currentWorkspaces.slice().reverse()

        Button {
            id: control

            padding: 0
            leftPadding: 0
            rightPadding: 0
            topPadding: 0
            bottomPadding: 0

            background: null

            anchors.centerIn: parent.centerIn

            property bool blinkState: false

            Timer {
                interval: 200
                running: modelData.number === workspaces.focusedWorkspace
                repeat: true

                onTriggered: {
                    control.blinkState = !control.blinkState
                }
            }

            contentItem: Text {
                id: workspaceText

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: modelData.number === 1
                    ? "[HOME]"
                    : `[${modelData.name.replace(/^[0-9]+:/, "")}]`

                font.family: textFont.name
                font.pixelSize: Config.settings.bar.fontSize

                anchors.verticalCenter: parent.verticalCenter

                color:
                    modelData.urgent
                        ? Config.colors.urgent
                        : modelData.number === workspaces.focusedWorkspace
                            ? control.blinkState
                                ? Config.colors.base
                                : Config.colors.dark
                            : Config.colors.dark

                Rectangle {
                    anchors.fill: parent
                    z: -1

                    color:
                        modelData.number === workspaces.focusedWorkspace
                            ? control.blinkState
                                ? Config.colors.dark
                                : Config.colors.base
                            : "transparent"
                }
            }

            onPressed: event => {
                I3.dispatch(`workspace ${modelData.name}`);
                event.accepted = true;
            }
        }
    }
}
