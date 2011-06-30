import QtQuick 1.0

// Pivot headers
Item {
    id: container

    height: 80
    width: 360

    property alias model: pathView.model
    // How wide the header is. Should be differentiated between portrait
    // and landscape modes.
    property int headerItemWidth: 182
    // Defines whether or not to show borders & and the color of it.
    property bool borders: true
    property color borderColor: "white"
    // Colors, text sizes etc.
    property color backgroundColor: "gray"
    property int headerTextSize: 36
    property color headerTextColor: "white"
    // Defines, whether the pathview can be flicked or only clicked.
    property bool flickable: true
    property bool landscape: false

    // Internal properties etc. do not use from outside!
    signal indexChanged(int index)
    property int currentIndex: 0

    Component {
        id: pivotHeaderDelegate

        Rectangle {
            height: parent.height
            width: container.headerItemWidth
            border.width: borders ? 2 : 0
            border.color: borders ? container.borderColor : "#00000000"

            color: container.backgroundColor
            Text {
                color: container.headerTextColor
                anchors.centerIn: parent
                opacity: PathView.transparency
                text: dayName
                font {
                    pixelSize: container.headerTextSize
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (pathView.currentIndex != index) {
                        console.log("Focusing on " + dayName +
                                    ". Clicked index was: " + index)
                        container.currentIndex = index;
                    }
                }
            }
        }
    }

    PathView {
        id: pathView

        anchors.fill: parent
        delegate: pivotHeaderDelegate
        pathItemCount: parent.landscape ? 4 : 3

        interactive: parent.flickable
        preferredHighlightBegin: parent.landscape ? 1/4 : 1/3
        preferredHighlightEnd: parent.landscape ? 1/4 : 1/3
        currentIndex: container.currentIndex
        onCurrentIndexChanged: {
            container.indexChanged(pathView.currentIndex)
        }

        path: Path {
            id: pivotPath
            property double scaleFactor: container.landscape ? 1/5 : 1/4

            // Start
            startX: -(container.headerItemWidth / 2)
            startY: container.height / 2
            PathAttribute { name: "transparency"; value: 0.3 }

            PathLine {
                x: container.width * pivotPath.scaleFactor;
                y: container.height / 2; }
            PathAttribute { name: "transparency"; value: 1.0 }

            PathLine {
                x: container.width * 2 * pivotPath.scaleFactor;
                y: container.height / 2; }
            PathAttribute { name: "transparency"; value: 0.3 }

            // Stop
            PathLine {
                x: container.width + (container.headerItemWidth / 2);
                y: container.height / 2; }
            PathAttribute { name: "transparency"; value: 0.0 }
        }
    }
}
