import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: "Nonogram QtQuick"

    Rectangle {
        width: 0.2 * parent.width
        height: parent.height
        color: "light grey"

        Button {
            id: check_button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 0.8 * parent.width
            height: 20
            text: "Check"
        }

        Label {
            anchors.centerIn: parent
            topPadding: -20
            text: "Mistakes left:"
        }

        Label {
            id: mistakes_left_label
            anchors.centerIn: parent
            topPadding: 20
            text: "100"
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            text: "Lives left:"
        }

        Label {
            id: lives_left_label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text: "100"
        }
    }

    Rectangle {
        width: 0.8 * parent.width
        height: parent.height
        x: 0.2 * parent.width
        color: "white"
    }


}
