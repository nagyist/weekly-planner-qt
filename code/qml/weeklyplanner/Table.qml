import QtQuick 1.0

Flickable {
    id: container
    width: 360
    height: 640

    property variant model: null
    property int selectedDay: 0
    property int numberOfColumnsToShow: 1

    property int dayWidth: numberOfColumnsToShow === 1 ? container.width - hourColumn.width - 30 : (container.width - hourColumn.width - 40)/2;

    contentWidth: 7*container.width
    contentHeight: container.height
    ListView {
        id: hourColumn
        anchors {
            left: parent.left
            top: parent.top
            bottom:  parent.bottom
            margins: 10
        }
        width: 80
        model: container.model.items()
        delegate: hourDelegate
        snapMode: ListView.SnapToItem
    }

    Row {
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: hourColumn.right
            margins: 10
        }

        spacing: 10
        ListView {
            id: monday
            width: dayWidth
            height: container.height
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
        }
        ListView {
            id: tuesday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
        }
        ListView {
            id: wednesday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
        }
        ListView {
            id: thursday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
        }
        ListView {
            id: friday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
        }
        ListView {
            id: saturday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
        }
        ListView {
            id: sunday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
        }
    }

    Component {
        id: hourDelegate
        Rectangle {
            id: hourRect
            width: parent.width
            height: 50*hourSpan
            z: hourSpan > 1 ? 10 : 1
            radius: 10
            color: "green"
            Text {
                anchors.centerIn: parent
                text: startTime
            }
        }
    }
    Component {
        id: cellDelegate
        Row {
            width: parent.width
            height: 50*hourSpan
            Rectangle {
                id: dataRect
                width: parent.width
                height: 50*hourSpan
                radius: 10
                z: hourSpan > 1 ? 10 : 1
                color: hourSpan > 1 ? "red" : "steelblue"
                Text {
                    anchors.centerIn: parent
                    text: itemData + " for " + hourSpan + " hours"
                }
            }
        }
    }
}
