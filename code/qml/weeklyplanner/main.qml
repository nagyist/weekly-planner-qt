import QtQuick 1.0

Item {
    id: container

    width: 360
    height: 640

    // Uses the Pivot component for showing/navigating through content.
    Pivot {
        id: mainPivot
        anchors.fill: parent
    }

    // Button for exiting the application.
    Button {
        anchors {
            top: parent.top
            right: parent.right
            margins: 5
        }
        width: 54
        height: 54
        onClicked: Qt.quit();
    }
}
