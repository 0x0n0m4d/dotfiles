pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var colors: themes[Config.settings.currentTheme] ?? themes['dark']
    property var themes: ({
        "dark": {
            "base": "#98971a",
            "dark": "#282828",
            "urgent": "#cc241d",
        }
    })

    property alias settings: settingsJsonAdapter.settings
    FileView {
        path: Qt.resolvedUrl("./settings.json")
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }

        JsonAdapter {
            id: settingsJsonAdapter
            property JsonObject settings: JsonObject {
                property string version: "0.1"
                property bool militaryTimeClockFormat: true
                property string currentTheme: "dark"
                property JsonObject bar: JsonObject {
                    property int fontSize: 18
                }
            }
        }
    }
}
