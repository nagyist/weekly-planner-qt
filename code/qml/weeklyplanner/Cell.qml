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
    color: container.backgroundColor
    z: 0

//    Component.onCompleted: {
//        console.log("Cell " + itemData + " created on QML side!")
//    }

    // Background image
    Image {
        anchors.fill: parent
        source: "gfx/text_field.png"
        visible: cellEdit.focus ? true : false
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

        // When focus changes, change the z-order so that the selected item
        // will be topmost.
        onFocusChanged: {
            if (focus == false) {
                container.z = 0;
                console.log("Deactivating focus from item " + itemData + " on index: " + index
                            + " focus: " + focus + " z:" + z)
            } else {
                container.z = 100;
                console.log("Activating focus from item " + itemData + " on index: " + index
                            + " focus: " + focus + " z:" + z)
            }
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

    // Popup tools for copying/pasting cell content.
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

    // Tools for merging the cells up/down and splitting merged cells.
    MergePopup {
        opacity: cellEdit.focus ? 1 : 0
        width: 50
        height: parent.height + 50
        spanCount: hourSpan

        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }

        onMergeDown: console.log("Cell, onMergeDown");
        onMergeUp: console.log("Cell, onMergeUp");
        onSplit: console.log("Cell, onSplit");
    }
}
