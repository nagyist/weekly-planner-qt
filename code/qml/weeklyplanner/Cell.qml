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
    z: hourSpan > 1 ? 10 : 1
    color: cellEdit.focus ? "#DDDDDD" : "#666666"

    function reset() {
        console.log("Item " + itemData + " reset called!")
    }

    ToolsPopup {
        id: tools

        opacity: cellEdit.focus ? 1 : 0
        anchors {
            bottom: parent.top
            left: parent.left
        }
    }

    TextEdit {
        id: cellEdit

        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        text: itemData + " for " + hourSpan + " hours"
        color: focus ? "black" : "white"

        onTextChanged: {
            // TODO: CALL MODEL SETTEXT -FUNCTION!
            setItemData(text);
        }
    }
}
