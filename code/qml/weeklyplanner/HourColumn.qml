import QtQuick 1.0

ListView {
    id: hourColumn

    Component.onCompleted: {
        console.log("HourColumn size: (" + hourColumn.width + "," + hourColumn.height + ")");
    }

    width: 80
    model: hourModel
    delegate: hourDelegate
    snapMode: ListView.SnapToItem
    // The hourColumn list & the dayItems should be flickable together,
    // thus marking these separately as non-interactive.
    interactive: false

    Component {
        id: hourDelegate
        Rectangle {
            Component.onCompleted: {
                console.log("HourItem " + startTime + " created on QML side!")
            }

            id: hourRect
            width: parent.width
            height: 50
            radius: 10
            color: "green"
            Text {
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
