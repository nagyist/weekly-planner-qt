import QtQuick 1.0

Rectangle {
    id: dayContainer

    property variant model: null

    width: 360
    height: 640
    color: "steelblue"

    ListView {
        id: weekDay

        anchors.fill: parent
        model: dayContainer.model
        delegate: Cell{}
        snapMode: ListView.SnapToItem
        interactive: false
    }

}
