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
    property bool landscape: false

    signal indexChanged(int index)

    Component {
        id: pivotHeaderDelegate

        Rectangle {
            height: parent.height
            width: headerRow.headerItemWidth
            border.color: headerRow.borderColor
            border.width: 2
            opacity: PathView.transparency

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
        pathItemCount: parent.landscape ? 4 : 3

        anchors.fill: parent
        preferredHighlightBegin: parent.landscape ? 1/4 : 1/3
        preferredHighlightEnd: parent.landscape ? 1/4 : 1/3
        currentIndex: headerRow.currentIndex
        onCurrentIndexChanged: {
            console.log("CurrentIndexChanged: " + pathView.currentIndex)
            headerRow.indexChanged(pathView.currentIndex)
        }

        path: Path {
            id: pivotPath
            property double scaleFactor: headerRow.landscape ? 1/5 : 1/4

            // Start
            startX: -(headerRow.headerItemWidth / 2)
            startY: headerRow.height / 2
            PathAttribute { name: "transparency"; value: 0.3 }

            PathLine {
                x: headerRow.width * pivotPath.scaleFactor;
                y: headerRow.height / 2; }
            PathAttribute { name: "transparency"; value: 1.0 }

            PathLine {
                x: headerRow.width * 2 * pivotPath.scaleFactor;
                y: headerRow.height / 2; }
            PathAttribute { name: "transparency"; value: 0.3 }

            // Stop
            PathLine {
                x: headerRow.width + (headerRow.headerItemWidth / 2);
                y: headerRow.height / 2; }
            PathAttribute { name: "transparency"; value: 0.0 }
        }
    }
}
