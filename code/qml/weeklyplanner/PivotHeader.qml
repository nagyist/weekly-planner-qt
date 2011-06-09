import QtQuick 1.0

// Pivot headers
ListView {
    id: headerRow

    property int headerItemWidth: 180
    property color borderColor: "white"
    property color backgroundColor: "gray"
    property color headerTextColor: "white"

    cacheBuffer: 7
    height: 80
    preferredHighlightBegin: 0
    preferredHighlightEnd: headerRow.headerItemWidth

    delegate: pivotHeaderDelegate
    orientation: ListView.Horizontal
    snapMode: ListView.SnapToItem
    highlightFollowsCurrentItem: true
    highlightRangeMode: ListView.StrictlyEnforceRange
    onCurrentIndexChanged: {
        console.log("Current idx changed to " + currentIndex);
        contentPane.currentIndex = currentIndex;
    }

    // ListView item prototype
    Component {
        id: pivotHeaderDelegate

        Rectangle {
            height: parent.height
            width: headerRow.headerItemWidth
            border.color: headerRow.borderColor
            border.width: 2

            color: headerRow.backgroundColor
            Text {
                color: headerRow.headerTextColor
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
                    contentPane.currentIndex = index;
                }
            }
        }
    }
}
