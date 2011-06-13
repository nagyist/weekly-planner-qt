import QtQuick 1.0

ListView {
    id: hourColumn

    property int itemHeight: 80
    property color backgroundColor: "gray"
    property color borderColor: "white"
    property color textColor: "white"

    function refresh() {
        console.log("Refreshed")
        hourColumn.model = 0;
        hourColumn.model = hourModel;
    }

    Component.onCompleted: {
        console.log("HourColumn size: (" + hourColumn.width + "," + hourColumn.height +
                    "), contentSize: (" +hourColumn.contentWidth + "x" + hourColumn.contentHeight + ")");
    }

    width: 80
    contentHeight: hourModel.count() * itemHeight

    model: hourModel
    delegate: hourDelegate
    snapMode: ListView.SnapToItem
    clip: true

    Component {
        id: hourDelegate

        Rectangle {
            id: hourRect

            Component.onCompleted: {
                console.log("HourItem " + startTime + " created on QML side!")
            }

            width: parent.width
            height: hourColumn.itemHeight
            border.color: hourColumn.borderColor
            border.width: 2
            color: hourColumn.backgroundColor

            Text {
                color: hourColumn.textColor
                //font.bold: true
                anchors.centerIn: parent
                text: startTime
            }
        }
    }

    ListModel {
        id: hourModel

        ListElement {
            startTime: "00:00"
        }
        ListElement {
            startTime: "01:00"
        }
        ListElement {
            startTime: "02:00"
        }
        ListElement {
            startTime: "03:00"
        }
        ListElement {
            startTime: "04:00"
        }
        ListElement {
            startTime: "05:00"
        }
        ListElement {
            startTime: "06:00"
        }
        ListElement {
            startTime: "07:00"
        }
        ListElement {
            startTime: "08:00"
        }
        ListElement {
            startTime: "09:00"
        }
        ListElement {
            startTime: "10:00"
        }
        ListElement {
            startTime: "11:00"
        }
        ListElement {
            startTime: "12:00"
        }
        ListElement {
            startTime: "13:00"
        }
        ListElement {
            startTime: "14:00"
        }
        ListElement {
            startTime: "15:00"
        }
        ListElement {
            startTime: "16:00"
        }
        ListElement {
            startTime: "17:00"
        }
        ListElement {
            startTime: "18:00"
        }
        ListElement {
            startTime: "19:00"
        }
        ListElement {
            startTime: "20:00"
        }
        ListElement {
            startTime: "21:00"
        }
        ListElement {
            startTime: "22:00"
        }
        ListElement {
            startTime: "23:00"
        }
    }
}
