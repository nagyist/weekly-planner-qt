import QtQuick 1.0
import Qt.labs.gestures 1.0

Item {
    id: container

    width: 360
    height: 640

    property bool landscape: container.width > container.height

    property int selectedDay: 0

    // Pivot headers
    ListView {
        id: headerRow
        property int pivotHeaderWidth: 200
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: 100
        model: week
        delegate: pivotHeaderDelegate
        orientation: ListView.Horizontal
    }

    Component {
        id: pivotHeaderDelegate
        Rectangle {
            height: parent.height
            width: headerRow.pivotHeaderWidth
            color: "steelblue"
            radius: 10
            Text {
                anchors.centerIn: parent
                text: dayName
                font {
                    pixelSize: 32
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked " + dayName + " at " + index)
                    headerRow.currentIndex = index;
                    container.selectedDay = index;
                }
            }
        }
    }

    // Content pane
    Table {
        id: contentPane
        clip: true
        model: week.day(container.selectedDay)
        numberOfColumnsToShow: container.landscape ? 2 : 1
        onModelChanged: {
            console.log("Tablemodel changed");
        }
        anchors {
            top: headerRow.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        GestureArea {
            anchors.fill: parent
            onTap: console.log("tap");
        }
    }
}
