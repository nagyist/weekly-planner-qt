import QtQuick 1.0

Rectangle {
    id: container

    width: 360
    height: 640
    color: "lightsteelblue"

    Pivot {
        id: mainPivot
        anchors.fill: parent
    }
}
