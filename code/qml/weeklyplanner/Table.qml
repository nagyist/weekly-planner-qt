import QtQuick 1.0

Flickable {
    id: table
    width: parent.width
    height: parent.height
    clip: true
    boundsBehavior: Flickable.StopAtBounds

    property variant model: null
    property int selectedDay: 0
    property int numberOfColumnsToShow: 1
    property int dayWidth: numberOfColumnsToShow == 1 ? table.width - hourColumn.width - 30 : (table.width - hourColumn.width - 40)/2;
    property int contentY: 0

    contentWidth: hourColumn.width + 7*(dayWidth+dayRow.spacing)+20
    contentHeight: hourColumn.height + monday.height
    flickableDirection: Flickable.VerticalFlick

    Component.onCompleted: {
        console.log("Flicakble table dimensions: (" + table.width + "x" + table.height + ")"
                    + " content dim: (" + table.contentWidth + "x" + table.contentHeight + ")"
                    + " dayWidth: " + table.dayWidth)
    }

    // This'll display the hour slots on the left
    HourColumn {
        id: hourColumn
        width: 80
        //height: table.height

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            margins: 1
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
            width: table.dayWidth
            model: table.model.day(0).items()
        }
        Day {
            id: tuesday
            width: table.dayWidth
            model: table.model.day(1).items()
        }
        Day {
            id: wednesday
            width: table.dayWidth
            model: table.model.day(2).items()
        }
        Day {
            id: thursday
            width: table.dayWidth
            model: table.model.day(3).items()
        }
        Day {
            id: friday
            width: table.dayWidth
            model: table.model.day(4).items()
        }
        Day {
            id: saturday
            width: table.dayWidth
            model: table.model.day(5).items()
        }
        Day {
            id: sunday
            width: table.dayWidth
            model: table.model.day(6).items()
        }
    }
}
