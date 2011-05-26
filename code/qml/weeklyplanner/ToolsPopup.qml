import QtQuick 1.0

Rectangle {
    id: toolsPopup

    width: 155
    height: 55
    color: "gray"
    // Hidden by default
    opacity: 0
    // Defines, how long shall the popup be visible (in ms)
    property int timeout: 2000

    signal edit()
    signal copy()
    signal paste()

    Row {
        spacing: 2

        // Three buttons
        Button {
            buttonName: "editButton"
            bgImage: "gfx/info.png"
            bgImagePressed: "gfx/info.png"

            width: 49
            height: 49
            opacity: 0.8

            onClicked: {
                console.log("EditButton onClicked");
                // Leave the toolbar visible, when entering edit mode
                // TODO: Implement the edit mode!
                hideTimer.stop()
                edit();
            }
        }

        Button {
            buttonName: "copyButton"
            bgImage: "gfx/zoom_out.png"
            bgImagePressed: "gfx/zoom_out.png"

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

            width: 49
            height: 49
            opacity: 0.8

            onClicked: {
                console.log("pasteButton onClicked");
                paste();
            }
        }
    }

    Timer {
        id: hideTimer
        interval: toolsPopup.timeout
        running: false
        repeat: false
        onTriggered: toolsPopup.state = ""
    }

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: toolsPopup
                opacity: 1.0
            }
            PropertyChanges {
                target: hideTimer
                running: true
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "visible"
            PropertyAnimation {
                target: toolsPopup
                properties: "opacity"
                duration: 200 }
        },
        Transition {
            from: "visible"
            to: ""
            NumberAnimation {
                target: toolsPopup
                properties: "opacity"
                duration: 500 }
        }
    ]
}
