import QtQuick 1.0

Item {
    id: container

    signal indexChanged(int index);

    property int itemHeight: 80
    property color textColor: "white"
    property color textColorFocus : "white"
    property variant model: null
    // These 2 properties are being forwarded to the Cell delegate.
    property string cellBackgroundImagePath: "gfx/cell_background.png"
    property string cellEditFocusImagePath: "gfx/text_field.png"

    signal contentYChanged(int y)
    property alias contentY: weekDay.contentY

    // Current index from the HourColumn. This will be used to position the
    // weekDay list component correctly, when it has fully loaded.
    property int hourIndex: 0

    width: 360
    height: 640

    ListView {
        id: weekDay

        Component.onCompleted: {
            console.log("weekDay w*h: (" + weekDay.width +
                        "x" + weekDay.height +
                        ") content w*h: (" + weekDay.contentWidth +
                        "x" + weekDay.contentHeight + ")");

            // When the component is loaded, set the list to correct position.
            positionViewAtIndex(container.hourIndex, ListView.Beginning);
        }

        anchors.fill: parent
        model: container.model
        contentHeight: container.itemHeight * weekDay.count
        snapMode: ListView.SnapToItem
        interactive: true
        cacheBuffer: 1920

        delegate: Cell {
            itemHeight: container.itemHeight
            textColor: container.textColor
            textColorFocus : container.textColorFocus
            cellBackgroundImagePath: container.cellBackgroundImagePath
            cellEditFocusImagePath: container.cellEditFocusImagePath

            onTextEdited: {
//                console.log("Item: " + index + " old text: " +
//                            itemData + " new text: " + newText);
                // Set the new text to the model (model will take care
                // checking whether the text has changed or not)
                container.model.setItemData(index, newText);
            }
            onMergeUp: {
                console.log("Merge up clicked. Index: " + index);
                container.model.mergeUp(index);
            }
            onMergeDown: {
                console.log("Merge down clicked. Index: " + index);
                container.model.mergeDown(index);
            }
            onSplit: {
                console.log("Split clicked. Index: " + index);
                container.model.split(index)
            }
        }

        onFlickEnded: {
            console.log("flick ended");
        }

        onCurrentIndexChanged: {
            container.indexChanged(currentIndex);
        }

        // Notify the changed value.
        onContentYChanged: container.contentYChanged(weekDay.contentY)
    }
}
