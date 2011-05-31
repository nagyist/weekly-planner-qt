import QtQuick 1.0
import Qt.labs.gestures 1.0

Item {
    id: container

    width: 360
    height: 640

    property bool landscape: container.width > container.height
    property int selectedDay: 0
    property int contentY: 0

    // Pivot headers
    ListView {
        id: headerRow

        property int pivotHeaderWidth: 200
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        cacheBuffer: 7
        height: 60
        model: week
        delegate: pivotHeaderDelegate
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        highlightFollowsCurrentItem: true
        preferredHighlightBegin: 0
        preferredHighlightEnd: 200
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
            width: headerRow.pivotHeaderWidth
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
                    viewSwitcher.switchView(days[index % days.length], currentIndex)
                    container.selectedDay = index;
                }
            }
        }
    }

    Flickable {
        id: contentPane

        Component.onCompleted: console.log("contentPane loaded");
        anchors {
            top: headerRow.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
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
                topMargin: 10
                bottomMargin: 10
            }
            color: "red"
            width: parent.width
            opacity: 1
        }

        PivotPage {
            id: tuesday
            anchors {
                top: parent.top
                bottom: parent.bottom
                topMargin: 10
                bottomMargin: 10
            }
            color: "green"
            width: parent.width
            opacity: 0
        }
        PivotPage {
            id: wednesday
            anchors {
                top: parent.top
                bottom: parent.bottom
                topMargin: 10
                bottomMargin: 10
            }
            color: "blue"
            width: parent.width
            opacity: 0
        }
        PivotPage {
            id: thursday
            anchors {
                top: parent.top
                bottom: parent.bottom
                topMargin: 10
                bottomMargin: 10
            }
            color: "orange"
            width: parent.width
            opacity: 0
        }
        PivotPage {
            id: friday
            anchors {
                top: parent.top
                bottom: parent.bottom
                topMargin: 10
                bottomMargin: 10
            }
            color: "steelblue"
            width: parent.width
            opacity: 0
        }
        PivotPage {
            id: saturday
            anchors {
                top: parent.top
                bottom: parent.bottom
                topMargin: 10
                bottomMargin: 10
            }
            color: "lightsteelblue"
            width: parent.width
            opacity: 0
        }
        PivotPage {
            id: sunday
            anchors {
                top: parent.top
                bottom: parent.bottom
                topMargin: 10
                bottomMargin: 10
            }
            color: "darkgray"
            width: parent.width
            opacity: 0
        }
    }
}

/*        HourColumn {
            id: hourColumn

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 10
            }
            width: contentPane.hourColumnWidth
        }
*/

/*
        // The actual views (in a row)
        Row {
            id: dayRow
            anchors {
                left: hourColumn.right
                top: parent.top
                bottom: parent.bottom
            }

            property int numberOfColumnsToShow: container.landscape ? 2 : 1
            property int dayWidth: numberOfColumnsToShow == 1 ? container.width - hourColumn.width - 30 : (container.width - hourColumn.width - 40)/2;

            Day {
                id: monday
                width: dayRow.dayWidth
                model: week.day(0).items()
                //numberOfColumnsToShow: container.landscape ? 2 : 1
            }
            Day {
                id: tuesday
                width: dayRow.dayWidth
                model: week.day(1).items()
            }
            Day {
                id: wednesday
                width: dayRow.dayWidth
                model: week.day(2).items()
            }
            Day {
                id: thursday
                width: dayRow.dayWidth
                model: week.day(3).items()
            }
            Day {
                id: friday
                width: dayRow.dayWidth
                model: week.day(4).items()
            }
            Day {
                id: saturday
                width: dayRow.dayWidth
                model: week.day(5).items()
            }
            Day {
                id: sunday
                width: dayRow.dayWidth
                model: week.day(6).items()
            }
        }
        */

