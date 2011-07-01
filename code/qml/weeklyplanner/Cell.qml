import QtQuick 1.0

Item {
    id: container

    property int itemHeight: 50
    // Define color of the text
    property color textColor: "white"
    property color textColorFocus : "white"
    // Background images for the Cell when focused & non-focused
    property string cellBackgroundImagePath: "gfx/cell_background.png"
    property string cellEditFocusImagePath: "gfx/text_field.png"

    // Internal properties, don't touch from outside!
    width: spanned ? 0 : parent.width
    height: spanned ? 0 : hourSpan * container.itemHeight
    // Visible only, if not under hour spanning
    visible: spanned ? false : true
    z: 0

    // For notifying whenever the Cell's item data has changed.
    signal textEdited(int index, string newText)
    // Cell merging and splitting notifications.
    signal mergeDown(int index);
    signal mergeUp(int index);
    signal split(int index);

//    Component.onCompleted: {
//        console.log("Cell " + itemData + " created on QML side!")
//    }

    // Background image.
    Image {
        id: bgImg
        anchors.fill: parent
        source: container.cellBackgroundImagePath
        visible: cellEdit.focus ? false : true
    }

    // Background image when editing the Cell.
    Image {
        anchors.fill: parent
        source: container.cellEditFocusImagePath
        visible: !bgImg.visible
    }

    TextEdit {
        id: cellEdit


        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        text: itemData
        color: focus ? container.textColorFocus : container.textColor
        // Don't use automatic focus. Makes the swiping experience better.
        activeFocusOnPress: false

        // This if for optimizing the performance by avoiding unnecessary
        // function calls to the model.
        property bool ready: false
        Component.onCompleted: {
            cellEdit.ready = true;
        }

        onTextChanged: {
            // Notify parent upon text change. Optimized a bit by preventing
            // calls to the model while the component is still in loading status.
            if (!cellEdit.ready) {
                //console.log("Still loading!");
            } else {
                container.textEdited(index, cellEdit.text);
            }
        }

        // When focus changes, change the z-order so that the selected item
        // will be topmost.
        onFocusChanged: {
            if (focus == false) {
                container.z = 0;
//                console.log("Deactivating focus from item " + itemData + " on index: " + index
//                            + " focus: " + focus + " z:" + z)
            } else {
                container.z = 100;
//                console.log("Activating focus from item " + itemData + " on index: " + index
//                            + " focus: " + focus + " z:" + z)
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

        onMergeDown: container.mergeDown(hourId);
        onMergeUp: {
            // "Fix" for UI getting trashed issue on split
            cellEdit.focus = false;
            container.mergeUp(hourId);
        }
        onSplit: container.split(hourId);
    }
}
