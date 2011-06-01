import QtQuick 1.0
import Qt.labs.gestures 1.0

Item {
    id: container

    width: 360
    height: 640

    property variant model: null
    property int headerHeight: 80
    property int headerItemWidth: 200

    // Internal properties, don't set from outside
    property bool landscape: container.width > container.height
    property int selectedDay: 0
    property int contentY: 0

    // Pivot headers
    ListView {
        id: headerRow

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        cacheBuffer: 7
        height: container.headerHeight
        model: week
        delegate: pivotHeaderDelegate
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        highlightFollowsCurrentItem: true
        preferredHighlightBegin: 0
        preferredHighlightEnd: container.headerItemWidth
        highlightRangeMode: ListView.StrictlyEnforceRange
        onCurrentIndexChanged: {
            console.log("Current idx changed to " + currentIndex);
            var days = [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
            viewSwitcher.switchView(days[currentIndex % days.length], currentIndex)
        }
    }

    Component {
        id: pivotHeaderDelegate

        Rectangle {
            height: parent.height
            width: container.headerItemWidth
            border.color: "white"
            border.width: 2

            color: "#666666"
            Text {
                color: "white"
                anchors.centerIn: parent
                text: dayName
                font {
                    pixelSize: 32
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked " + dayName + " at " + index);
                    headerRow.currentIndex = index;
                    var days = [monday, tuesday, wednesday, thursday, friday, saturday, sunday];
                    viewSwitcher.switchView(days[index % days.length], false)
                    container.selectedDay = index;
                }
            }
        }
    }

    HourColumn {
        id: hourColumn

        anchors {
            left: parent.left
            top: headerRow.bottom
            bottom: parent.bottom
            leftMargin: 10
            rightMargin: 10
            topMargin: 10
            bottomMargin: 10
        }
    }

    Flickable {
        id: contentPane

        Component.onCompleted: console.log("contentPane loaded");
        anchors {
            top: headerRow.bottom
            bottom: parent.bottom
            left: hourColumn.right
            right: parent.right
            topMargin: 10
            bottomMargin: 10
            leftMargin: 10
            rightMargin: 10
        }
        contentWidth: width*1.5
        flickableDirection: Flickable.HorizontalFlick
        clip: true

        onFlickableDirectionChanged: {
            console.log("onFlickableDirectionChanged");
        }

        onFlickingChanged: {
            console.log("onFlickingChanged");
        }

        onFlickStarted: {
            console.log("onFlickStarted");
        }

        onFlickEnded: {
            console.log("onFlickEnded");
        }

        // View switcher component, handles the view switching and animation
        ViewSwitcher {
            id: viewSwitcher
            // Rooted in contentPane
            root: contentPane
            currentView: monday
        }

        PivotPage {
            id: monday
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width
            opacity: 1
            model: week.day(0).items()
        }

        PivotPage {
            id: tuesday
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width
            opacity: 0
            model: week.day(1).items()
        }
        PivotPage {
            id: wednesday
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width
            opacity: 0
            model: week.day(2).items()
        }
        PivotPage {
            id: thursday
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width
            opacity: 0
            model: week.day(3).items()
        }
        PivotPage {
            id: friday
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width
            opacity: 0
            model: week.day(4).items()
        }
        PivotPage {
            id: saturday
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width
            opacity: 0
            model: week.day(5).items()
        }
        PivotPage {
            id: sunday
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width
            opacity: 0
            model: week.day(6).items()
        }
    }
}
