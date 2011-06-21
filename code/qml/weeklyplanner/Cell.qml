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

    // Background image
    Image {
        anchors.fill: parent
        source: "gfx/text_field.png"
        visible: cellEdit.focus ? true : false
    }

    CopyPastePopup {
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
        // Don't use automatic focus. Makes the swiping experience better.
        activeFocusOnPress: false

        onTextChanged: {
            //console.log("Text changed, setting new text to model");
            // TODO: CALL MODEL SETTEXT -FUNCTION!
            //setItemData(cellEdit.text);
        }

        // Manually adjust the text edit focus.
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!cellEdit.activeFocus) {
                    cellEdit.forceActiveFocus();
                    cellEdit.openSoftwareInputPanel();
                } else {
                    cellEdit.focus = false;
                }
            }
            onPressAndHold: cellEdit.closeSoftwareInputPanel();
        }
    }
}
