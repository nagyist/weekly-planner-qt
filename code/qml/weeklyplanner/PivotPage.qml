import QtQuick 1.0
import Templates 1.0

Item {
    id: dayContainer

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
        model: dayContainer.model
        delegate: Cell {
            itemHeight: dayContainer.itemHeight
            textColor: dayContainer.textColor
            textColorFocus: dayContainer.textColorFocus
            backgroundColor: dayContainer.backgroundColor
            backgroundColorFocus: dayContainer.backgroundColorFocus
            borderColor: dayContainer.borderColor
        }
        snapMode: ListView.SnapToItem
        interactive: true
        onFlickEnded: {
            console.log("flick ended");
        }

        onCurrentIndexChanged: {
            console.log("IDX: " + currentIndex);
        }
    }

}
