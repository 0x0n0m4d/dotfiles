import QtQuick

import Quickshell
import Quickshell.Io
import QtQuick.Controls.Basic

import ".."

Button {
    id: root

    property var command: []
    property int interval: 1000

    property string output: ""

    implicitHeight: 22
    implicitWidth: Math.max(22, label.contentWidth + 12)

    NewBorder {
        commonBorderWidth: 1
        commonBorder: false
        lBorderwidth: 0
        rBorderwidth: 1
        tBorderwidth: 0
        bBorderwidth: 1
        borderColor: Config.colors.outline
        zValue: -1
    }

    background: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height
        border.width: 1
        border.color: Config.colors.outline
        color: "transparent"
        radius: 0

        Text {
            id: label

            anchors.centerIn: parent

            text: root.output

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font.family: textFont.name
            font.pixelSize: Config.settings.bar.fontSize + 2

            color: Config.colors.text
        }
    }
    Process {
        id: process

        command: root.command

        stdout: StdioCollector {
            onStreamFinished: {
                root.output = text.trim()
            }
        }

        onExited: {
            poll.restart()
        }
    }

    Timer {
        id: poll

        interval: root.interval
        repeat: false

        onTriggered: {
            process.running = true
        }
    }

    Component.onCompleted: {
        process.running = true
    }
}
