import QtQuick 1.0

Item {
    id: container
    signal indexChanged(int index)
    property alias model: contentPane.model
    property alias currentIndex: contentPane.currentIndex
    property int pageHeight: 640

    property int contentY: 0
    signal contentYChanged(int y)

    ListView {
        id: contentPane

        // This is for copy-paste functionality.
        property string clipboard: ""

        Component.onCompleted: {
            console.log("Content pane loaded");
        }

        clip: true
        anchors.fill: parent
        orientation: ListView.Horizontal
        highlightMoveDuration: 330
        snapMode: ListView.SnapToItem
        highlightFollowsCurrentItem: true
        preferredHighlightBegin: 0
        preferredHighlightEnd: contentPane.width
        highlightRangeMode: ListView.StrictlyEnforceRange
        delegate: pageDelegate
        onCurrentIndexChanged: container.indexChanged(currentIndex);
    }

    Component {
        id: pageDelegate

        PivotPage {
            width: contentPane.width
            height: container.pageHeight
            model: container.model.day(index).items()

            // TODO: THIS CAUSES BINDING LOOP!
//            contentY: container.contentY
            // TODO: THIS CAUSES BINDING LOOP!

            onContentYChanged: {
                // Notify of the PivotPage's content's vertical movement.
                container.contentYChanged(y);
            }
        }
    }
}
