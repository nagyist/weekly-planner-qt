import QtQuick 1.0

Flickable {
    id: container
    width: 360
    height: 640
    boundsBehavior: Flickable.StopAtBounds

    property variant model: null
    property int selectedDay: 0
    property int numberOfColumnsToShow: 1

    property int dayWidth: numberOfColumnsToShow === 1 ? container.width - hourColumn.width - 30 : (container.width - hourColumn.width - 40)/2;

    property int contentY: 0

    contentWidth: hourColumn.width + 7*(dayWidth+dayRow.spacing)+20
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
        onContentYChanged: container.contentY = contentY
        contentY: container.contentY
    }

    Row {
        id: dayRow
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
            onContentYChanged: container.contentY = contentY
            contentY: container.contentY
        }
        ListView {
            id: tuesday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
            onContentYChanged: container.contentY = contentY
            contentY: container.contentY
        }
        ListView {
            id: wednesday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
            onContentYChanged: container.contentY = contentY
            contentY: container.contentY
        }
        ListView {
            id: thursday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
            onContentYChanged: container.contentY = contentY
            contentY: container.contentY
        }
        ListView {
            id: friday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
            onContentYChanged: container.contentY = contentY
            contentY: container.contentY
        }
        ListView {
            id: saturday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
            onContentYChanged: container.contentY = contentY
            contentY: container.contentY
        }
        ListView {
            id: sunday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
            snapMode: ListView.SnapToItem
            onContentYChanged: container.contentY = contentY
            contentY: container.contentY
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
