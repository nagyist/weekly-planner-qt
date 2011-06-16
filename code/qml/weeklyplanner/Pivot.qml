import QtQuick 1.0

Rectangle {
    id: container

    width: 640
    height: 360
    color: "lightgray"

    // Model HAS TO BE set in order for the Pivot to work!
    property variant model: week
    // How high the header is. Can be differentiated between portrait
    // and landscape modes.
    property int headerHeight: 70
    property int headerItemWidth: landscape ? 214 : 182
    // Colors, colors, colors.
    property color backgroundColor: "gray"
    property color backgroundColorFocus: "lightGray"
    property color borderColor: "white"
    property color textColor: "white"
    property color textColorFocus: "red"
    property color headerTextColor: "white"

    // Internal properties, don't set from outside.
    property bool landscape: container.width > container.height

    // Pivot headers, used for navigation.
    PivotHeader {
        id: headerRow

        model: parent.model
        height: parent.headerHeight
        headerItemWidth: parent.headerItemWidth
        landscape: parent.landscape
        // Don't show borders on the header items
        borders: false
        // If the header should work both ways and by flicking,
        // set this property to true. Now it works just by clicking items.
        flickable: false

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

    // Column on the left, showing the hours. Stays the same in each view.
    HourColumn {
        id: hourColumn

        // Set the hourColumn to be quite narrow. The anchors will
        // define the hourColumn's height.
        width: 60
        itemHeight: 80

        anchors {
            top: headerRow.bottom
            bottom: parent.bottom
            left: parent.left
            topMargin: 2
            leftMargin: 2
            rightMargin: 1
        }

        textColor: container.textColor
        backgroundColor: container.backgroundColor
        borderColor: container.borderColor

        onContentYChanged: {
            // Bind the contentPane to move with the hourColumn
            contentPane.contentY = hourColumn.contentY;
        }
    }

    // The content pane. Contains the hour cell items in a list / day.
    PivotContentPane {
        id: contentPane

        model: parent.model
        pageHeight: container.height - container.headerHeight
        landscape: parent.landscape
        anchors {
            top: headerRow.bottom
            bottom: parent.bottom
            left: hourColumn.right
            right: parent.right
            topMargin: 2
            leftMargin: 1
            rightMargin: 2
        }

        onIndexChanged: {
//            console.log("Contentpane index changed: " + index);
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
