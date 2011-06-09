import QtQuick 1.0

// Pivot headers
Item {
    id: headerRow

    height: 80
    width: 360

    property alias model: pathView.model
    property int headerItemWidth: 180
    property int currentIndex: 0
    property color borderColor: "white"
    property color backgroundColor: "gray"
    property color headerTextColor: "white"

    signal indexChanged(int index)

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
                    if (pathView.currentIndex != index) {
                        console.log("Focusing on " + dayName +
                                    ". Clicked index was: " + index)
                        headerRow.currentIndex = index;
                    }
                }
            }
        }
    }

    PathView {
        id: pathView

        delegate: pivotHeaderDelegate
        pathItemCount: 3

        anchors.fill: parent
        preferredHighlightBegin: 0.3333
        preferredHighlightEnd: 0.3333
        currentIndex: headerRow.currentIndex
        onCurrentIndexChanged: {
            console.log("CurrentIndexChanged: " + pathView.currentIndex)
            headerRow.indexChanged(pathView.currentIndex)
        }

        path: Path {
            // Start
            startX: -90
            startY: headerRow.height / 2

            // Stop
            PathLine { x: headerRow.width + 90; y: headerRow.height / 2; }
        }
    }
}
