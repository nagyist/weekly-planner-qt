import QtQuick 1.0

Rectangle {
    id: container

    width: 640
    height: 360
    color: "lightgray"

    property variant model: null
    property int headerHeight: 70
    property int headerItemWidth: landscape ? 214 : 182
    property color backgroundColor: "gray"
    property color backgroundColorFocus: "lightGray"
    property color borderColor: "white"
    property color textColor: "white"
    property color textColorFocus: "red"
    property color headerTextColor: "white"

    // Internal properties, don't set from outside
    property bool landscape: container.width > container.height

    PivotHeader {
        id: headerRow

        model: week
        height: parent.headerHeight
        headerItemWidth: parent.headerItemWidth
        landscape: parent.landscape
        // Don't show borders on the header items
        borders: false

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        onIndexChanged: {
            console.log("PivotHeader index changed: " + index);
            contentPane.currentIndex = index;
            // Change the correct day also to the HourColumn
            hourColumn.refresh();
        }
    }

    HourColumn {
        id: hourColumn

        height: container.height
        width: 60
        itemHeight: 80

        anchors {
            top: headerRow.bottom
            bottom: parent.bottom
            left: parent.left
            topMargin: 2
            leftMargin: 2
            rightMargin: 2
        }

        contentHeight: itemHeight*24
        textColor: container.textColor
        backgroundColor: container.backgroundColor
        borderColor: container.borderColor

        onContentYChanged: {
            contentPane.contentY = hourColumn.contentY;
        }
    }

    PivotContentPane {
        id: contentPane
        model: week
        pageHeight: container.height - container.headerHeight
        anchors {
            top: headerRow.bottom
            bottom: parent.bottom
            left: hourColumn.right
            right: parent.right
            topMargin: 2
            leftMargin: 2
            rightMargin: 2
        }
        onIndexChanged: {
            console.log("Contentpane index changed: " + index);
            headerRow.currentIndex = index;
            // Change the correct day also to the HourColumn
            hourColumn.refresh();
        }

        // Bind the hourcolumn to move with the PivotPage
        onContentYChanged: {
//            console.log("PivContPane, onContYChged, new Y: " + y);
            hourColumn.contentY = y;
        }
    }
}
