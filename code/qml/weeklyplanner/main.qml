import QtQuick 1.0

Rectangle {
    id: container

    width: 360
    height: 640
    color: "lightsteelblue"

    Text {
        text: "Hello World"
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }
}
