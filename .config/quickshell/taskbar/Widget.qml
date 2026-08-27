import QtQuick
import ".."

Row {
    id: root

    property string value: ""
    property bool blink: false
    property bool blinkState: false

    spacing: 5

    Timer {
        id: blinkTimer

        interval: 200
        running: root.blink
        repeat: true

        onTriggered: {
            root.blinkState = !root.blinkState
        }
    }

    onBlinkChanged: {
        if (!blink)
            blinkState = false
    }

    Rectangle {
        width: contentText.implicitWidth
        height: contentText.implicitHeight

        color: root.blink && root.blinkState
            ? Config.colors.dark
            : Config.colors.base

        Text {
            id: contentText

            anchors.centerIn: parent

            text: root.value

            color: root.blink && root.blinkState
                ? Config.colors.base
                : Config.colors.dark

            font.pixelSize: Config.settings.bar.fontSize
            font.family: textFont.name
        }
    }
}
