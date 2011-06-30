import QtQuick 1.0

Item {
    id: container

    signal indexChanged(int index);

    property int itemHeight: 80
    property color textColor: "white"
    property color textColorFocus: "black"
    property color backgroundColor: "#666666"
    property color backgroundColorFocus: "#DDDDDD"
    property color borderColor: "white"
    property variant model: null

    signal contentYChanged(int y)
    property alias contentY: weekDay.contentY

    width: 360
    height: 640

    ListView {
        id: weekDay

        Component.onCompleted: {
            console.log("weekDay w*h: (" + weekDay.width + "x" + weekDay.height +
                        ") \ncontent w*h: (" + weekDay.contentWidth + "x" + weekDay.contentHeight + ")");
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
            textColorFocus: container.textColorFocus
            backgroundColor: container.backgroundColor
            backgroundColorFocus: container.backgroundColorFocus
            borderColor: container.borderColor

            onTextEdited: {
                // Set the new text to the model (model will take care
                // checking whether the text has changed or not)
//                console.log("Item: " + index + " old text: " +
//                            itemData + " new text: " + newText);
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
            console.log("IDX: " + currentIndex);
        }

        // Notify the changed value.
        onContentYChanged: container.contentYChanged(weekDay.contentY)
    }
}
