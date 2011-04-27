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
        Row {
            width: parent.width
            height: 50
        Rectangle {
            id: timeRect
            width: parent.width / 4
            height: 50
            radius: 10
            color: "green"
            Text {
                anchors.centerIn: parent
                text: startTime
            }
        }
        Rectangle {
            id: dataRect
            width: parent.width / 4*3
            height: 50
            radius: 10
            color: "steelblue"
            Text {
                anchors.centerIn: parent
                text: itemData
            }
        }
        }
    }
}
