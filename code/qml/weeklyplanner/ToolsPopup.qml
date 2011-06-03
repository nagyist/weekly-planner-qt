import QtQuick 1.0

Rectangle {
    id: container

    signal clicked
    signal copy()
    signal paste()

    property color backgroundColor: "gray"
    property color borderColor: "black"
    property int borderWidth: 2
    property int iconSpacing: 5

    // Defines, how long shall the popup be visible (in ms)
    property int timeout: 2000

    width: 102
    height: 56
    color: backgroundColor
    // Hidden by default
    opacity: 0
    border {
        width: container.borderWidth
        color: container.borderColor
    }


    Row {
        spacing: container.iconSpacing
        width: parent.width
        height: parent.height

        // Buttons for copying and pasting the cell content
        Button {
            buttonName: "copyButton"
            bgImage: "gfx/zoom_out.png"
            bgImagePressed: "gfx/zoom_out.png"
            anchors.verticalCenter: parent.verticalCenter

            width: 49
            height: 49
            opacity: 0.8

            onClicked: {
                console.log("copyButton onClicked");
                copy();
                container.clicked();
            }
        }

        Button {
            buttonName: "pasteButton"
            bgImage: "gfx/zoom_out.png"
            bgImagePressed: "gfx/zoom_out.png"
            anchors.verticalCenter: parent.verticalCenter

            width: 49
            height: 49
            opacity: 0.8

            onClicked: {
                console.log("pasteButton onClicked");
                paste();
                container.clicked();
            }
        }
    }

    //    Timer {
    //        id: hideTimer
    //        interval: toolsPopup.timeout
    //        running: toolsPopup.opacity > 0 ? true : false
    //        repeat: false
    //        onTriggered: {
    //            toolsPopup.opacity = 0
    //        }
    //    }

    Behavior on opacity {
        NumberAnimation {
            duration: 350
            easing.type: Easing.InOutQuad
        }
    }
}
