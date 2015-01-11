import QtQuick 2.0
import QtQuick.Controls 1.2

ApplicationWindow {
    width: 800
    height: 480
    visible: true

    property var levels: [
        0.3, 0.58, 0.1, 0.25, 0.8
    ]
    onLevelsChanged: console.log(levels)

    Column {
        spacing: 10
        anchors.centerIn: parent

        Bar {
            percentage: levels [0]
        }

        Bar {
            percentage: levels [1]
        }

        Bar {
            percentage: levels [2]
        }

        Bar {
            percentage: levels [3]
        }

        Bar {
            percentage: levels [4]
        }
    }

    Timer {
        interval: 300
        running: true
        repeat: true
        onTriggered: {
            var newLevels = []
            for (var i = 0; i < levels.length; ++i)
                newLevels.push(Math.random())
            levels = newLevels
        }
    }
}

