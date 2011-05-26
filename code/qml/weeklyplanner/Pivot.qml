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
        height: 100
        model: week
        delegate: pivotHeaderDelegate
        orientation: ListView.Horizontal
    }

    Component {
        id: pivotHeaderDelegate
        Rectangle {
            height: parent.height
            width: headerRow.pivotHeaderWidth
            color: "steelblue"
            radius: 10
            Text {
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
                    viewSwitcher.switchView(days[index], index)
                    container.selectedDay = index;
                }
            }
        }
    }

    // Content pane
    Table {
        id: contentPane
        width: container.width
        height: container.height

        model: week
        numberOfColumnsToShow: container.landscape ? 2 : 1

        anchors {
            top: headerRow.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        onModelChanged: {
            console.log("Tablemodel changed");
        }
    }

/*
    Flickable {
        id: contentPane

        width: parent.width
        height: parent.height
        clip: true

        anchors {
            top: headerRow.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        contentWidth: hourColumn.width + monday.width*7
        contentHeight: hourColumn.height + monday.height
        flickableDirection: Flickable.VerticalFlick

        HourColumn {
            id: hourColumn

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 10
            }
        }

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

        // View switcher component, handles the view switching and animation
        ViewSwitcher {
            id: viewSwitcher
            // Rooted in contentPane
            root: contentPane
        }

        GestureArea {
            anchors.fill: parent
            focus: true

            onTap: {
                console.log("tap pos = (",gesture.position.x,",",gesture.position.y,")")
                if ( gesture.position.x < 320 ) {

                }
            }
            onTapAndHold: {
                console.log("tap and hold pos = (",gesture.position.x,",",gesture.position.y,")")

            }

            // These are not working!
//            onPan: {
//                console.log("pan delta = (",gesture.delta.x,",",gesture.delta.y,") acceleration = ",gesture.acceleration);
//            }
//            onSwipe: {
//                console.log("swipe angle=",gesture.swipeAngle);
//            }
//            onGesture: {
//                console.log("gesture hot spot = (",gesture.hotSpot.x,",",gesture.hotSpot.y,")");
//            }
        }
    }
*/
}
