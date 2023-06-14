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
    }
}