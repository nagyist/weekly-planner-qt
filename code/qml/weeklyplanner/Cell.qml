import QtQuick 1.0

Rectangle {
    id: cellDelegate

    Component.onCompleted: {
        console.log("Component " + itemData + " created on QML side!")
    }

    width: parent.width
    height: 50*hourSpan
    border.color: "white"
    border.width: 2
    //radius: 10
    z: hourSpan > 1 ? 10 : 1
    color: hourSpan > 1 ? "#848484" : "#666666"

    Text {
        id: cellText

        color: "white"
        //font.bold: true
        anchors.centerIn: parent
        text: itemData + " for " + hourSpan + " hours"
    }

    TextEdit {
        id: cellEdit
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        visible: false
        text: itemData + " for " + hourSpan + " hours"
    }

    MouseArea {
        anchors.fill: parent
        // Todo, on clicked, show the tools!
        onClicked: {
            console.log("Clicked on: " + itemData)
            tools.opacity = 1
        }
    }

    ToolsPopup {
        id: tools

        anchors {
            bottom: parent.top
            left: parent.left
        }

        onEdit: {
            console.log("onEdit() signal captured!")
            cellText.visible = false
            cellEdit.visible = true
            cellEdit.focus = true
        }
    }
}
