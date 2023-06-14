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

            text: qsTr("Dialogs")
            source: ""
        }

        ButtonWireframeIcon {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20

            text: "Message"
            source: "qrc:/assets/icons_material/baseline-delete-24px.svg"

            PopupMessage {
                id: popupMessage
            }

            onClicked: popupMessage.open()
        }

        ButtonWireframeIcon {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20

            text: "Choice"
            source: "qrc:/assets/icons_material/baseline-delete-24px.svg"

            PopupChoice {
                id: popupChoice
            }

            onClicked: popupChoice.open()
        }

        SectionTitle { /////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 12
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 12

            text: qsTr("Date & time pickers")
            source: ""
        }

        ButtonWireframeIcon {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20

            text: "Date"
            source: "qrc:/assets/icons_material/duotone-date_range-24px.svg"

            PopupDate {
                id: popupDate
            }

            onClicked: popupDate.openDate(new Date())
        }

        ButtonWireframeIcon {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20

            text: "Time"
            source: "qrc:/assets/icons_material/duotone-schedule-24px.svg"

            PopupTime {
                id: popupTime
            }

            onClicked: popupTime.open()
        }
    }
}