import QtQuick 1.0

Rectangle {
    id: container

    width: 360
    height: 640
    color: "lightgray"

    property variant model: null
    property int headerHeight: 80
    property int headerItemWidth: 180
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

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        onIndexChanged: {
            console.log("PivotHeader index changed: " + index);
            contentPane.currentIndex = index;
        }
    }

    HourColumn {
        id: hourColumn

        anchors {
            left: parent.left
            top: headerRow.bottom
            leftMargin: 4
            rightMargin: 4
            topMargin: 6
        }
        itemHeight: 80
        height: itemHeight*24
        textColor: container.textColor
        backgroundColor: container.backgroundColor
        borderColor: container.borderColor
    }

    PivotContentPane {
        id: contentPane
        model: week
        pageHeight: hourColumn.height
        anchors {
            top: headerRow.bottom
            bottom: parent.bottom
            left: hourColumn.right
            right: parent.right
            topMargin: 6
            leftMargin: 4
            rightMargin: 4
        }
        onIndexChanged: {
            console.log("Contentpane index changed: " + index);
            headerRow.currentIndex = index;
        }
    }
}
