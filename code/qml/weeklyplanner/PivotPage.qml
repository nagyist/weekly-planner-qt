import QtQuick 1.0

Item {
    id: dayContainer

    property variant model: null

    width: 360
    height: 640

    ListView {
        id: weekDay

        anchors.fill: parent
        model: dayContainer.model
        delegate: Cell {}
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
