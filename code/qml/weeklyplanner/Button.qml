import QtQuick 1.0

Item {
    id: container

    property string buttonName: ""
    property string text: ""

    property string fontName: ""
    property int fontSize: 12
    property color fontColor: "black"
    property bool fontBold: false

    property bool active: false

    property string bgImage: 'gfx/exit_button.png';
    property string bgImagePressed: 'gfx/exit_button.png';
    property string bgImageActive: '';

    signal clicked(string button)

    width: 54
    height: 54
    opacity: enabled ? 1.0 : 0.5    

    BorderImage {
        id: background
        border { top: 0; bottom: 0; left: 0; right: 0; }
        source: bgImage
        width: parent.width
        height: parent.height
    }

    Text {
        id: buttonLabel
        text: parent.text
        wrapMode: Text.WordWrap

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        font {
            family: container.fontName
            pointSize: container.fontSize
            bold: container.fontBold
        }
        color: container.fontColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.clicked(buttonName);
    }

    states: [
        State {
            name: 'pressed'; when: mouseArea.pressed
            PropertyChanges { target: background; source: bgImagePressed; border { left: 38; top: 37; right: 38; bottom: 15 } }
        },
        State {
            name: 'active'; when: container.active
            PropertyChanges { target: background; source: bgImageActive; }
        }
    ]
}
