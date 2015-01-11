import QtQuick 2.0
import QtQuick.Controls 1.2

ApplicationWindow {
    width: 800
    height: 480
    visible: true

    property var levels: spectrumModel.frequencies

    Column {
        spacing: 10
        anchors.centerIn: parent

        Repeater {
            model: levels.length
            delegate: Bar {
                percentage: levels[index]
            }
        }
    }
}

