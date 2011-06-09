import QtQuick 1.0
import Qt.labs.gestures 1.0

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
    property int selectedDay: 0
    property int contentY: 0

    // Pivot headers
    ListView {
        id: headerRow

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        Component.onCompleted: {
            currentIndex = 0;
            contentPane.currentIndex = 0;
        }

        cacheBuffer: 7
        height: container.headerHeight
        model: week
        delegate: pivotHeaderDelegate
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        highlightFollowsCurrentItem: true
        preferredHighlightBegin: 0
        preferredHighlightEnd: container.headerItemWidth
        highlightRangeMode: ListView.StrictlyEnforceRange
        onCurrentIndexChanged: {
            console.log("Current idx changed to " + currentIndex);
            contentPane.currentIndex = currentIndex;
        }
    }

    Component {
        id: pivotHeaderDelegate

        Rectangle {
            height: parent.height
            width: container.headerItemWidth
            border.color: container.borderColor
            border.width: 2

            color: container.backgroundColor
            Text {
                color: container.headerTextColor
                anchors.centerIn: parent
                text: dayName
                font {
                    pixelSize: 32
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked " + dayName + " at " + index);
                    headerRow.currentIndex = index;
                    container.selectedDay = index;
                    contentPane.currentIndex = index;
                }
            }
        }
    }

    HourColumn {
        id: hourColumn

        anchors {
            left: parent.left
            top: headerRow.bottom
            leftMargin: 10
            rightMargin: 10
            topMargin: 10
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
            topMargin: 10
            leftMargin: 10
            rightMargin: 10
        }
    }
}
