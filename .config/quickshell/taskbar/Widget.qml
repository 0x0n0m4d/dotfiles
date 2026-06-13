import QtQuick
import ".."

Row {
    id: root

    property string value: ""
    property string icon: ""
    property string currentTextColor: Config.colors.text
    property string currentIconColor: Config.colors.text

    spacing: 5

    Text {
        id: iconText

        text: root.icon
        color: root.currentIconColor
        font.pixelSize: Config.settings.bar.fontSize
        font.family: iconFont.name
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: contentText

        text: root.value
        color: root.currentTextColor
        font.pixelSize: Config.settings.bar.fontSize
        font.family: textFont.name
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
