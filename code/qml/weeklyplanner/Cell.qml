import QtQuick 1.0

Rectangle {
    id: cellDelegate

    property color textColor: "white"
    property color textColorFocus: "black"
    property color backgroundColor: "#666666"
    property color backgroundColorFocus: "#DDDDDD"
    Component.onCompleted: {
        //console.log("Component " + itemData + " created on QML side!")
    }


    width: parent.width
    height: 50*hourSpan
    border.color: "white"
    border.width: 2
    z: hourSpan > 1 ? 10 : 1
    color: cellEdit.focus ? backgroundColorFocus : backgroundColor

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
        onClicked: cellEdit.focus = false;
    }

    TextEdit {
        id: cellEdit

        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        text: itemData + " for " + hourSpan + " hours"
        color: focus ? container.textColorFocus : container.textColor

        onTextChanged: {
            //console.log("Text changed, setting new text to model");
            // TODO: CALL MODEL SETTEXT -FUNCTION!
            //setItemData(cellEdit.text);
        }
    }
}
