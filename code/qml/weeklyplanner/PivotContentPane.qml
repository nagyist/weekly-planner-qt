import QtQuick 1.0

Item {
    property alias model: contentPane.model
    property alias currentIndex: contentPane.currentIndex

    ListView {
        id: contentPane

        Component.onCompleted: {
            console.log("Content pane loaded");
            currentIndex = 0;
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
            width: contentPane.width - 20
            height: hourColumn.height
            color: {
                // Just a test
                var colors = ["red", "green", "blue", "orange", "gray", "steelblue", "fuchsia"];
                return colors[index % colors.length];
            }
        }
    }
}
