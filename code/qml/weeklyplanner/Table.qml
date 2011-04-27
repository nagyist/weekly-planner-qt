import QtQuick 1.0

Item {
    id: container
    width: 360
    height: 640

    property variant model: null

    ListView {
        anchors.fill:  parent
        anchors.margins: 10

        model: container.model
        delegate: cellDelegate
    }

    Component {
        id: cellDelegate
        Rectangle {
            id: timeRect
            width: parent.width
            height: 50
            radius: 10
            color: "green"
            Text {
                anchors.centerIn: parent
                text: startTime
            }
        }
    }
}
