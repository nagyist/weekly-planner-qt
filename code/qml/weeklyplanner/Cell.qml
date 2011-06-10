import QtQuick 1.0

Rectangle {
    id: container

    property int itemHeight: 50
    property color textColor: "white"
    property color textColorFocus: "black"
    property color backgroundColor: "#666666"
    property color backgroundColorFocus: "#DDDDDD"
    property color borderColor: "white"

    width: parent.width
    height: hourSpan * container.itemHeight
    border.color: container.borderColor
    border.width: 2
    color: cellEdit.focus ? container.backgroundColorFocus : container.backgroundColor

    function reset() {
        console.log("Item " + itemData + " reset called!")
    }

    ToolsPopup {
        id: tools

        opacity: cellEdit.focus ? 1 : 0
        anchors {
            bottom: parent.top
            left: parent.left
            margins: 2
        }
        onClicked: cellEdit.focus = false;

        onCopy: contentPane.clipboard = cellEdit.text;
        onPaste: cellEdit.text = contentPane.clipboard;
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
