import QtQuick 1.0

Flickable {
    id: container
    width: parent.width
    height: parent.height
    clip: true
    boundsBehavior: Flickable.StopAtBounds

    property variant model: null
    property int selectedDay: 0
    property int numberOfColumnsToShow: 1
    property int dayWidth: numberOfColumnsToShow == 1 ? container.width - hourColumn.width - 30 : (container.width - hourColumn.width - 40)/2;
    property int contentY: 0

    contentWidth: hourColumn.width + 7*(dayWidth+dayRow.spacing)+20
    contentHeight: hourColumn.height + monday.height
    flickableDirection: Flickable.VerticalFlick

    Component.onCompleted: {
        console.log("Flicakble table dimensions: (" + container.width + "x" + container.height + ")"
                    + " content dim: (" + container.contentWidth + "x" + container.contentHeight + ")"
                    + " dayWidth: " + container.dayWidth)
    }

    // This'll display the hour slots on the left
    HourColumn {
        id: hourColumn

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            margins: 10
        }
    }

    // The actual views (in a row)
    Row {
        id: dayRow
        anchors {
            left: hourColumn.right
            top: parent.top
            bottom: parent.bottom
        }

        Day {
            id: monday
            width: container.dayWidth
            model: container.model.day(0).items()
        }
        Day {
            id: tuesday
            width: container.dayWidth
            model: container.model.day(1).items()
        }
        Day {
            id: wednesday
            width: container.dayWidth
            model: container.model.day(2).items()
        }
        Day {
            id: thursday
            width: container.dayWidth
            model: container.model.day(3).items()
        }
        Day {
            id: friday
            width: container.dayWidth
            model: container.model.day(4).items()
        }
        Day {
            id: saturday
            width: container.dayWidth
            model: container.model.day(5).items()
        }
        Day {
            id: sunday
            width: container.dayWidth
            model: container.model.day(6).items()
        }
    }
}
