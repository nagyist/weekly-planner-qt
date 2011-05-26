import QtQuick 1.0

QtObject {
    id: viewSwitcher
    property Item currentView
    property Item previousView
    property int previousIndex

    property Item root

    property int duration: 250
    property bool running: switchAnimation.running
    property bool direction

    function switchView(newView, index, instant) {
        if (newView != currentView && !switchAnimation.running) {
            console.log("in switchView!")

            var leftToRight = index < previousIndex ? true : false;
            console.log("Index: " + index + " previousIndex: " + previousIndex + " leftToRight: " + leftToRight );
            newView.x = leftToRight ? -root.width : root.width;
            direction = leftToRight;
            previousView = currentView;
            previousIndex = index
            currentView = newView;
            newView.opacity = 1;
            switchAnimation.start();
            if (instant) {
                console.log("Instant switch!")
                switchAnimation.complete();
            }
        }
    }

    property variant switchAnimation :
        ParallelAnimation {
        NumberAnimation { target: previousView; property: "x"; easing.type: Easing.InOutSine
            to: direction ? root.width : -root.width; duration: viewSwitcher.duration }
        NumberAnimation { target: currentView; property: "x"; easing.type: Easing.InOutSine; to: 0; duration: viewSwitcher.duration  }

        onRunningChanged:  {
            if (!running && previousView) {
                previousView.opacity = 0;
            }
        }
    }
}
