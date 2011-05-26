import QtQuick 1.0



Rectangle {
    id: cellDelegate

    Component.onCompleted: {
        console.log("Component " + itemData + " created on QML side!")
    }

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
        // Todo, on clicked, show the tools!
        onClicked: {
            console.log("Clicked on: " + itemData)
            tools.state = "visible"
        }
    }

    ToolsPopup {
        id: tools

        anchors {
            bottom: parent.top
            left: parent.left
        }

        onEdit: console.log("onEdit() signal captured!")
    }
}
