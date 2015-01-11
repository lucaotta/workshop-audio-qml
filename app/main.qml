import QtQuick 2.0
import QtQuick.Controls 1.0

ApplicationWindow {
    width: 100
    height: 62
    visible: true

    Text {
        text: "Hello world!"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit()
    }
}

