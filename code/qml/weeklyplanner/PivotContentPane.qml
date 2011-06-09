import QtQuick 1.0

Item {
    id: container
    property alias model: contentPane.model
    property alias currentIndex: contentPane.currentIndex
    property int pageHeight: 640
    ListView {
        id: contentPane

        Component.onCompleted: {
            console.log("Content pane loaded");
        }

        anchors {
            fill: parent
        }
        clip: true
        orientation: ListView.Horizontal
        highlightMoveDuration: 330
        delegate: pageDelegate
    }

    Component {
        id: pageDelegate

        Rectangle {
            width: contentPane.width
            height: container.pageHeight
            color: {
                // Just a test
                var colors = ["red", "green", "blue", "orange", "gray", "steelblue", "fuchsia"];
                return colors[index % colors.length];
            }
        }
    }
}
