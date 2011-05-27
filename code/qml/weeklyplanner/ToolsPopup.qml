import QtQuick 1.0

Rectangle {
    id: toolsPopup

    width: 102
    height: 56
    color: "gray"
    // Hidden by default
    opacity: 0
    // Defines, how long shall the popup be visible (in ms)
    property int timeout: 2000

    signal copy()
    signal paste()
    //signal edit()

    Row {
        spacing: 2
        width: parent.width
        height: parent.height

//        // Three buttons
//        // NOTE: NO NEED FOR SEPARATE EDIT-BUTTON?
//        Button {
//            buttonName: "editButton"
//            bgImage: "gfx/info.png"
//            bgImagePressed: "gfx/info.png"
//            anchors.verticalCenter: parent.verticalCenter

//            width: 49
//            height: 49
//            opacity: 0.8

//            onClicked: {
//                console.log("EditButton onClicked");
//                // Leave the toolbar visible, when entering edit mode
//                // TODO: Implement the edit mode!
//                hideTimer.stop()
//                edit();
//            }
//        }

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
