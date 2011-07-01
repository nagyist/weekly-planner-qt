import QtQuick 1.0

Rectangle {
    id: container

    width: 640
    height: 360
    color: "black"

    // Model HAS TO BE set in order for the Pivot to work!
    // The model also has to be compatible with QAbstarctListModel.
    property variant model: week
    // How high the header is. Can be differentiated between portrait
    // and landscape modes.
    property int headerHeight: 70
    // Defines the width of one header item.
    property int headerItemWidth: landscape ? 214 : 182
    // Color definitions. Modify in order to change the text colors.
    property color textColor: "white"
    property color textColorFocus: "white"
    property color headerTextColor: "lightgray"
    // Define the UI graphics.
    property string headerBgImage: "gfx/header_background.png"
    property string hourColumnBgImage: "gfx/hour_background.png"
    property string cellBackgroundImagePath: "gfx/cell_background.png"
    property string cellEditFocusImagePath: "gfx/text_field.png"

    // Internal properties, don't set from outside. This is used to
    // determine in which orientation the screen is.
    property bool landscape: width > height

    // Pivot headers, used for navigation.
    PivotHeader {
        id: headerRow

        model: parent.model
        height: parent.headerHeight
        width: parent.width
        headerItemWidth: parent.headerItemWidth
        // Set the background image
        backgroundImagePath: parent.headerBgImage
        headerTextColor: parent.headerTextColor
        landscape: parent.landscape
        // If the header should work both ways and by flicking,
        // set this property to true.
        flickable: true

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

        // Define the colors & background images used
        textColor: parent.textColor
        backgroundImagePath: parent.hourColumnBgImage

        onContentYChanged: {
            // Bind the contentPane to move with the hourColumn
            contentPane.contentY = hourColumn.contentY;
        }
    }

    // The content pane. Contains the hour cell items in a list / day.
    PivotContentPane {
        id: contentPane

        model: parent.model
        pageHeight: parent.height - parent.headerHeight
        landscape: parent.landscape
        // Set the background graphics & text colors etc.
        cellBackgroundImagePath: parent.cellBackgroundImagePath
        cellEditFocusImagePath: parent.cellEditFocusImagePath
        textColor: parent.textColor
        textColorFocus: parent.textColorFocus
        // Bind this with hourColumn's current index. This way the content
        // listing will position itself correctly when page is switched.
        hourIndex: hourColumn.hourIndex

        anchors {
            top: headerRow.bottom
            bottom: parent.bottom
            left: hourColumn.right
            right: parent.right
            topMargin: 2
            leftMargin: 0
            rightMargin: 2
        }

        onIndexChanged: {
            headerRow.currentIndex = index;
        }

        // Bind the hourcolumn to move with the PivotPage
        onContentYChanged: {
            hourColumn.contentY = y;
        }
    }
}
