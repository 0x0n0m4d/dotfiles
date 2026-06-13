import Quickshell
import Quickshell.Io
import QtQuick

import "../popups" as Popups
import ".."

Scope {
    // Taskbar variants, we have one taskber per screen.
    Variants {
        model: Quickshell.screens
        Item {
            id: root
            required property var modelData
            property int currentPopup: Config.SystemPopup.None

            PanelWindow {
                id: taskbar
                screen: root.modelData

                anchors {
                    top: true
                    left: true
                    right: true
                }
                implicitHeight: 35

                /*=== Taskbar Background (colors & shading) ===*/
                color: Config.colors.base
                Item {
                    id: taskbarBackground
                    anchors.fill: parent
                    NewBorder {
                        commonBorderWidth: 4
                        commonBorder: false
                        lBorderwidth: 10
                        rBorderwidth: 1
                        tBorderwidth: 10
                        bBorderwidth: 1
                        borderColor: Config.colors.shadow
                    }
                    NewBorder {
                        commonBorderWidth: 4
                        commonBorder: false
                        lBorderwidth: 10
                        rBorderwidth: 10
                        tBorderwidth: 1
                        bBorderwidth: 10
                        borderColor: Config.colors.highlight
                    }

                    Rectangle {
                        id: barBackground
                        anchors {
                            fill: parent
                            margins: 0
                        }
                        color: "transparent"
                        radius: 0
                        border.width: 1
                        border.color: Config.colors.outline
                    }
                }
                /*=== ===================================== ===*/

                /*=== Workspaces & Background for it ===*/
                Item {
                    id: workspacesButtons
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    height: parent.height - 8

                    anchors.leftMargin: 11
                    width: workspaces.width + 5
                    Rectangle {
                        id: background2
                        anchors.fill: workspacesButtons

                        anchors.bottomMargin: -2
                        color: "transparent"
                        Rectangle {
                            anchors.fill: background2
                            border.width: 0
                            color: Config.colors.shadow
                        }
                        Rectangle {
                            anchors.fill: background2
                            color: "transparent"
                            border.width: 1
                            z: -5
                            anchors.margins: -1
                            anchors.bottomMargin: 1
                        }
                    }
                    Workspaces {
                        id: workspaces
                        anchors.leftMargin: 2
                        anchors.rightMargin: 0
                    }
                }
                /*=== ============================== ===*/
                /*=== StartMenu & Other popup Stuff ===*/
                Popups.StartMenu {
                    id: startMenu
                    menuWidth: workspaces.width + startmenuButton.width
                    closeCallback: taskbar.closeAllPopups
                }
                Popups.ThemeMenu {
                    id: themeMenu
                    menuWidth: workspaces.width + startmenuButton.width + themeMenuButton.width
                }
                function closeAllPopups() {
                    switch (root.currentPopup) {
                    case Config.SystemPopup.Startmenu:
                        startMenu.closeStartMenu();
                        break;
                    case Config.SystemPopup.ThemePicker:
                        themeMenu.closeThemeMenu();
                        break;
                    }
                    root.currentPopup = Config.SystemPopup.None;
                }

                TaskbarButton {
                    id: startmenuButton
                    isToggled: root.currentPopup == Config.SystemPopup.Startmenu ? true : false
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: workspaces.width + 20 + 4
                    onClicked: {
                        if (root.currentPopup == Config.SystemPopup.None) {
                            startMenu.openStartMenu();
                            root.currentPopup = Config.SystemPopup.Startmenu;
                        } else {
                            taskbar.closeAllPopups();
                            root.currentPopup = Config.SystemPopup.None;
                        }
                    }
                }
                TaskbarButton {
                    id: themeMenuButton
                    isToggled: root.currentPopup == Config.SystemPopup.ThemePicker ? true : false
                    iconFontValue: "\udb80\udfeb"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: workspaces.width + 40 + 11
                    fontSize: 18
                    onClicked: {
                        if (root.currentPopup == Config.SystemPopup.None) {
                            themeMenu.openThemeMenu();
                            root.currentPopup = Config.SystemPopup.ThemePicker;
                        } else {
                            taskbar.closeAllPopups();
                            root.currentPopup = Config.SystemPopup.None;
                        }
                    }
                }
                /*=== Timer in here ===*/
                TaskbarCard {
                    id: timeCard
                    anchors.centerIn: parent
                    command: ["sh", "-c", "/home/n0m4d/.config/scripts/time.sh"]
                    interval: 1000
                }
                /*=== ============================= ===*/

                /*=== System Tray & Background for it ===*/
                Item {
                    id: sysTrayWidget
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    height: parent.height - 8
                    width: sysTray.width + 18
                    Rectangle {
                        id: background
                        anchors.fill: sysTrayWidget

                        anchors.bottomMargin: -2
                        color: "transparent"
                        Rectangle {
                            anchors.fill: background
                            border.width: 0
                            color: Config.colors.shadow
                        }
                        Rectangle {
                            anchors.fill: background
                            color: "transparent"
                            border.width: 1
                            z: -5
                            anchors.margins: -1
                            anchors.bottomMargin: 1
                        }
                    }
                    SysTray {
                        id: sysTray
                    }
                }
                /*=== =============================== ===*/
            }

            /*=== POPUP CLOSING PANEL ===*/
            // PanelWindow {
            //     id: clickCatcher
            //     visible: popup.visible
            //     anchors { top: true; bottom: true; left: true; right: true }
            //     color: "transparent"
            //
            //     MouseArea {
            //         anchors.fill: parent
            //         onClicked: popup.visible = false
            //     }
            // }
            /*=== =================== ===*/
        }
    }

    enum SystemPopups {
        Startmenu,
        ThemePicker,
        None
    }
}
