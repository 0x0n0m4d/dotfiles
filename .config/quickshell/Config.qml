pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var colors: themes[themes[settings.currentTheme] == null ? '光' : settings.currentTheme]
    property var themes: {
        "光": {
            "base": "#98a4a5",
            "shadow": "#767f7f",
            "highlight": "#a6b2b2",
            "urgent": "#a31210",
            "accent": "#158c82",
            "text": "#00161c",
            "workspaceFocusedText": "#00161c",
            "outline": "#00161c",
            "outlineGradientFade": "#767f7f",
            "defaultWallpaperPath": "",
        },
        "黑暗": {
            "base": "#00161c",
            "shadow": "#0a353f",
            "highlight": "#396772",
            "urgent": "#cc0300",
            "accent": "#00dbcc",
            "text": "#a6b2b2",
            "workspaceFocusedText": "#a6b2b2",
            "outline": "#a6b2b2",
            "outlineGradientFade": "#0a353f",
            "defaultWallpaperPath": "",
        }
    }

    enum SystemPopup {
        Startmenu,
        ThemePicker,
        None
    }

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
                property string systemProfileImageSource: "/home/n0m4d/Pictures/icon.png"
                property string currentTheme: "光"
                property bool setWallpaperToThemeWallpaper: true
                property JsonObject execCommands: JsonObject {
                    property string terminal: "kitty"
                    property string firefox: "firefox-esr"
                    property string spotify: "spotify"
                }
                property JsonObject systemDetails: JsonObject {
                    property string osName: "Distro Linux"
                    property string osVersion: "Distro Version"
                    property string ram: "Ram"
                    property string cpu: "CPU Name"
                    property string gpu: "GPU Name"
                }
                property JsonObject bar: JsonObject {
                    property int fontSize: 12
                    property int trayIconSize: 16
                    property bool monochromeTrayIcons: true
                }

                onCurrentThemeChanged: {
                    console.info("Updated theme to: " + currentTheme);
                }
            }
        }
    }
}
