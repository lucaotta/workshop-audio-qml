import QtQuick 2.0

Rectangle {
    id: bg

    property real percentage: 0.7

    height: 40
    width: 200
    color: "darkgray"

    Rectangle {
        id: bar
        height: bg.height - 6
        width: (bg.width - 6) * percentage
        color: "green"
        anchors.verticalCenter: bg.verticalCenter
        anchors.left: bg.left
        anchors.leftMargin: 3

        Behavior on width {
            NumberAnimation { duration: 100; easing.type: Easing.Linear }
        }
    }
}
