import QtQuick 1.0

Item {
    width: 360
    height: 640

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
        model: WeekModel { id: weekModel }
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
        clip: true
        anchors {
            top: headerRow.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
