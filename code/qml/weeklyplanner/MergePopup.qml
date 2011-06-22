import QtQuick 1.0

Item {
    width: 100
    height: 100

    property int iconSpacing: 2

    // Two buttons for merging the Cell up/down
    Button {
        buttonName: "mergeUpButton"
        bgImage: "gfx/merge_up.png"
        bgImagePressed: "gfx/merge_up.png"

        width: 45
        height: 45
        opacity: 0.8

        anchors {
//            right: parent.right
            top: parent.top
            leftMargin: parent.iconSpacing
            horizontalCenter: parent.horizontalCenter
        }

        onClicked: {
            console.log("mergeUpButton onClicked");
//            paste();
//            container.clicked();
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
//            right: parent.right
            bottom: parent.bottom
            leftMargin: parent.iconSpacing
            horizontalCenter: parent.horizontalCenter
        }

        onClicked: {
            console.log("mergeDownButton onClicked");
//            paste();
//            container.clicked();
        }
    }

    Button {
        buttonName: "splitButton"
        bgImage: "gfx/split.png"
        bgImagePressed: "gfx/split.png"

        width: 45
        height: 45
        opacity: 0.8
        // TODO!!!
        visible: false

        anchors {
//            right: parent.right
            leftMargin: parent.iconSpacing
            horizontalCenter: parent.horizontalCenter
        }

        onClicked: {
            console.log("splitButton onClicked");
//            paste();
//            container.clicked();
        }
    }
}
