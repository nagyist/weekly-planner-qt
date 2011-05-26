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
        delegate: dayDelegate
        snapMode: ListView.SnapToItem
        interactive: false

        Component {
            id: dayDelegate
            Rectangle {
                Component.onCompleted: {
                    console.log("Component " + itemData + " created on QML side!")
                }

                id: dataRect
                width: dayContainer.width
                height: 50*hourSpan
                radius: 10
                z: hourSpan > 1 ? 10 : 1
                color: hourSpan > 1 ? "red" : "steelblue"
                Text {
                    anchors.centerIn: parent
                    text: itemData + " for " + hourSpan + " hours"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log("Clicked on: " + itemData)
                }
            }
        }
    }
}
