import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: isDesktop; }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20

        topPadding: 16
        bottomPadding: 16
        spacing: 16

        SectionTitle { /////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 12
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 12

            text: qsTr("Title")
            source: ""
        }

        Row {
            CheckBoxThemed {
                anchors.verticalCenter: parent.verticalCenter
                text: "CheckBox"
            }
        }

        Row {
            RadioButtonThemed {
                id: radioButtonLight
                anchors.verticalCenter: parent.verticalCenter

                text: "light"
                checked: true
            }
            RadioButtonThemed {
                id: radioButtonDark
                anchors.verticalCenter: parent.verticalCenter

                text: "dark"
                checked: false
            }
        }

        SectionTitle { /////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 12
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 12

            text: qsTr("Switches")
            source: ""
        }

        SwitchThemedDesktop {
            text: "Switch"
            checked: true
        }

        SwitchThemedMobile {
            text: "Switch"
            checked: true
        }
    }
}