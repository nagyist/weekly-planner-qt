import QtQuick 1.0
import Templates 1.0

Item {
    id: container

    signal indexChanged(int index);

    property int itemHeight: 80
    property color textColor: "white"
    property color textColorFocus: "black"
    property color backgroundColor: "#666666"
    property color backgroundColorFocus: "#DDDDDD"
    property color borderColor: "white"
    property variant model: null

    width: 360
    height: 640

    ListView {
        id: weekDay

        anchors.fill: parent
        model: container.model
        delegate: Cell {
            itemHeight: container.itemHeight
            textColor: container.textColor
            textColorFocus: container.textColorFocus
            backgroundColor: container.backgroundColor
            backgroundColorFocus: container.backgroundColorFocus
            borderColor: container.borderColor
        }
        snapMode: ListView.SnapToItem
        interactive: true
        onFlickEnded: {
            console.log("flick ended");
        }

        onCurrentIndexChanged: {
            container.indexChanged(currentIndex);
            console.log("IDX: " + currentIndex);
        }
    }

}
