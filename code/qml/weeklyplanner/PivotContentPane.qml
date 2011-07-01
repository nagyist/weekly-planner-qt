import QtQuick 1.0

Item {
    id: container

    // The model has to be QAbstractListModel compatible!
    property alias model: contentPane.model

    property int pageHeight: 640
    property bool landscape: false
    // Background images for single cells (active & non-avtive).
    property string cellBackgroundImagePath: "gfx/cell_background.png"
    property string cellEditFocusImagePath: "gfx/text_field.png"
    // Text color properties.
    property color textColor: "white"
    property color textColorFocus : "white"

    property alias currentIndex: contentPane.currentIndex
    property int contentY: 0
    // For binding with the hourColumn's current index.
    property int hourIndex: 0

    signal contentYChanged(int y)
    signal indexChanged(int index)

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
        snapMode: ListView.SnapOneItem
        flickDeceleration: landscape ? 3000 : 500
        highlightFollowsCurrentItem: true
        preferredHighlightBegin: 0
        preferredHighlightEnd: contentPane.width
        highlightRangeMode: ListView.StrictlyEnforceRange
//        cacheBuffer: width * 3 // Caches 3 days

        delegate: pageDelegate
        onCurrentIndexChanged: {
            container.indexChanged(currentIndex);
        }
    }

    Component {
        id: pageDelegate

        PivotPage {
            width: contentPane.width
            height: container.pageHeight
            model: container.model.day(index).items()
            cellBackgroundImagePath: container.cellBackgroundImagePath
            cellEditFocusImagePath: container.cellEditFocusImagePath
            textColor: container.textColor
            textColorFocus : container.textColorFocus
            hourIndex: container.hourIndex

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
