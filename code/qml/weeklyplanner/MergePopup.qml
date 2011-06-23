import QtQuick 1.0

Item {
    id: container

    width: 100
    height: 100
    property int iconSpacing: 2
    property int spanCount: 1

    signal mergeDown();
    signal mergeUp();
    signal split();

    // Two buttons for merging the Cell up/down
    Button {
        buttonName: "mergeUpButton"
        bgImage: "gfx/merge_up.png"
        bgImagePressed: "gfx/merge_up.png"

        width: 45
        height: 45
        opacity: 0.8

        anchors {
            top: parent.top
            leftMargin: parent.iconSpacing
            horizontalCenter: parent.horizontalCenter
        }

        onClicked: {
            console.log("mergeUpButton onClicked");
            container.mergeUp();
        }
    }

    Button {
        buttonName: "mergeDownButton"
        bgImage: "gfx/merge_down.png"
        bgImagePressed: "gfx/merge_down.png"

        width: 45
        height: 45
        opacity: 0.8

        anchors {
            bottom: parent.bottom
            leftMargin: parent.iconSpacing
            horizontalCenter: parent.horizontalCenter
        }

        onClicked: {
            console.log("mergeDownButton onClicked");
            container.mergeDown();
        }
    }

    // One button for splitting the merged cells. Visible only if the
    // cell has a spanCount more than one!
    Button {
        buttonName: "splitButton"
        bgImage: "gfx/split.png"
        bgImagePressed: "gfx/split.png"

        width: 45
        height: 45
        opacity: 0.8
        visible: spanCount > 1

        anchors {
            leftMargin: parent.iconSpacing
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        onClicked: {
            console.log("splitButton onClicked");
            container.split();
        }
    }
}
