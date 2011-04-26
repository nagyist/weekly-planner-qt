import QtQuick 1.0

Item {
    width: 360
    height: 640

    ListModel {
        id: pivotPages
        ListElement {
            title: "Pivot 1"
        }
        ListElement {
            title: "Pivot 2"
        }
        ListElement {
            title: "Pivot 3"
        }
        ListElement {
            title: "Pivot 4"
        }
        ListElement {
            title: "Pivot 5"
        }
    }

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
        model: pivotPages
        delegate: pivotHeaderDelegate
        orientation: ListView.Horizontal
        onCurrentIndexChanged: console.log("change")
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
                text: title
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked " + title + " at " + index)
                    headerRow.currentIndex = index;
                }
            }
        }
    }

     // Content pane
    Table {
        id: contentPane
        anchors {
            top: headerRow.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
