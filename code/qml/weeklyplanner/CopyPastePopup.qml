import QtQuick 1.0

Item {
    id: container

    signal clicked
    signal copy()
    signal paste()

    property string backgroundImage: "gfx/copy_paste_background.png"
    property int borderWidth: 2
    property int iconSpacing: 5

    // Defines, how long shall the popup be visible (in ms)
    property int timeout: 2000

    width: 102
    height: 56
    // Hidden by default
    opacity: 0

    // Background image
    Image {
        anchors.fill: parent
        source: container.backgroundImage
    }
    // Buttons for copying and pasting the cell content
    Button {
        id: copyButton

        buttonName: "copyButton"
        bgImage: "gfx/copy.png"
        bgImagePressed: "gfx/copy.png"
        anchors.verticalCenter: parent.verticalCenter

        width: 45
        height: 45
        opacity: 0.8

        anchors {
            left: parent.left
            leftMargin: parent.iconSpacing
        }

        onClicked: {
            console.log("copyButton onClicked");
            copy();
            container.clicked();
        }
    }

    Button {
        buttonName: "pasteButton"
        bgImage: "gfx/paste.png"
        bgImagePressed: "gfx/paste.png"
        anchors.verticalCenter: parent.verticalCenter

        width: 45
        height: 45
        opacity: 0.8

        anchors {
            left: copyButton.right
            leftMargin: parent.iconSpacing
        }

        onClicked: {
            console.log("pasteButton onClicked");
            paste();
            container.clicked();
        }
    }

    //    Timer {
    //        id: hideTimer
    //        interval: container.timeout
    //        running: container.opacity > 0 ? true : false
    //        repeat: false
    //        onTriggered: {
    //            container.opacity = 0
    //        }
    //    }

    Behavior on opacity {
        NumberAnimation {
            duration: 350
            easing.type: Easing.InOutQuad
        }
    }
}
