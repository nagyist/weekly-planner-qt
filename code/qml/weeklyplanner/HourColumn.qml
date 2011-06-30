import QtQuick 1.0

Item {
    id: container

    // Defines the column height. Should be set from outside.
    property int itemHeight: 80
    // Settable colors.
    property color backgroundColor: "gray"
    property color borderColor: "white"
    property color textColor: "white"
    // Defined in order to scorll the hour column with content pane.
    property alias contentY: hourColumn.contentY

    // Signalled, when hour column's y-coordinate changes.
    signal contentYChanged()
    // Called when the page switches. Resets the hour column back to 00:00.
    function refresh() {
        console.log("Refreshed");
        hourColumn.positionViewAtIndex(0, ListView.Beginning);
    }

    // Hours are being shown in a vertical list
    ListView {
        id: hourColumn

        anchors.fill: parent
        contentHeight: hourModel.count * container.itemHeight

        model: hourModel
        delegate: hourDelegate
        snapMode: ListView.SnapToItem
        clip: true
        interactive: false
        // Cache the whole hourcolumn into memory.
        cacheBuffer: 1920

        Component.onCompleted: {
            console.log("HourColumn size: (" + hourColumn.width + "," + hourColumn.height +
                        "), contentSize: (" + hourColumn.contentWidth + "x" + hourColumn.contentHeight + ")" +
                        " hourModel count: " + hourModel.count + " itemHeight: " + container.itemHeight);
        }

        onContentYChanged: {
            container.contentYChanged();
        }
    }

    // Hour prototype item.
    Component {
        id: hourDelegate

        Item {
            id: hourRect

//            Component.onCompleted: {
//                console.log("HourItem " + startTime + " created on QML side!")
//            }

            width: container.width
            height: container.itemHeight

            // Background image
            Image {
                anchors.fill: parent
                source: "gfx/hour_background.png"
            }

            Text {
                color: container.textColor
                anchors.centerIn: parent
                text: startTime
            }
        }
    }

    // Static list containing the hours.
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
