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
        model: week
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
                font {
                    pixelSize: 32
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked " + title + " at " + index)
                    headerRow.currentIndex = index;
                    if (index === 0) {
                        contentPane.model = monday;
                    } else if (index === 1) {
                        contentPane.model = tuesday;
                    } else if (index === 2) {
                        contentPane.model = wednesday;
                    } else if (index === 3) {
                        contentPane.model = thursday;
                    } else if (index === 4) {
                        contentPane.model = friday;
                    }
                }
            }
        }
    }

    // Content pane
    Table {
        id: contentPane
        clip: true
        model: monday
        anchors {
            top: headerRow.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
