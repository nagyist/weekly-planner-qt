import QtQuick 1.0

Item {
    id: container
    property alias model: contentPane.model
    property alias currentIndex: contentPane.currentIndex
    property int pageHeight: 640
    ListView {
        id: contentPane

        Component.onCompleted: {
            console.log("Content pane loaded");
        }

        anchors {
            fill: parent
        }
        clip: true
        orientation: ListView.Horizontal
        highlightMoveDuration: 330
        snapMode: ListView.SnapToItem
        highlightFollowsCurrentItem: true
        preferredHighlightBegin: 0
        preferredHighlightEnd: contentPane.width
        highlightRangeMode: ListView.StrictlyEnforceRange
        delegate: pageDelegate
    }

    Component {
        id: pageDelegate

        PivotPage {
            width: contentPane.width
            height: container.pageHeight
            model: container.model.day(index).items()
        }
    }
}
