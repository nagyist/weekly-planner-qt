import QtQuick 1.0

Item {
    id: dayContainer

    Component.onCompleted: {
        console.log("Listview size: (" + weekDay.width + "," + weekDay.height + ")");
    }

    property variant model: null
    property int selectedDay: 0
    property int numberOfColumnsToShow: 1
    property int contentY: 0

    anchors {
        top: parent.top
        bottom: parent.bottom
        margins: 10
    }

    ListView {
        id: weekDay

        anchors.fill: parent
        model: dayContainer.model
        delegate: Cell{}
        snapMode: ListView.SnapToItem
        interactive: false
    }
}
