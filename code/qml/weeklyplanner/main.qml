import QtQuick 1.0

Item {
    id: container

    width: 360
    height: 640

    Pivot {
        id: mainPivot
        anchors.fill: parent
        headerHeight: 80
        headerItemWidth: 180
    }

    Button {
        anchors {
            top: parent.top
            right: parent.right
            margins: 5
        }
        width: 54
        height:  54
        onClicked: Qt.quit();
    }
}
