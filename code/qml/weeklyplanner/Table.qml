import QtQuick 1.0

Flickable {
    id: container
    width: 360
    height: 640

    property variant model: null
    property int selectedDay: 0
    property int numberOfColumnsToShow: 1

    property int dayWidth: container.width - 20;

    contentWidth:  7*container.width
    contentHeight: container.height
    Row {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10
        ListView {
            id: monday
            width: dayWidth
            height: container.height
            model: container.model.items()
            delegate: cellDelegate
        }
        ListView {
            id: tuesday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
        }
        ListView {
            id: wednesday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
        }
        ListView {
            id: thursday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
        }
        ListView {
            id: friday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
        }
        ListView {
            id: saturday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
        }
        ListView {
            id: sunday
            height: container.height
            width: dayWidth
            model: container.model.items()
            delegate: cellDelegate
        }
    }

    Component {
        id: cellDelegate
        Row {
            width: parent.width
            height: 50*hourSpan
            Rectangle {
                id: timeRect
                width: parent.width / 4
                height: 50*hourSpan
                z: hourSpan > 1 ? 10 : 1
                radius: 10
                color: "green"
                Text {
                    anchors.centerIn: parent
                    text: startTime
                }
            }
            Rectangle {
                id: dataRect
                width: parent.width / 4*3
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
