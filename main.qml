import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import NonogramModel 1.0


ApplicationWindow {
    id: root
    property var nmodel: NonogramModel
    width: 640
    height: 480
    visible: true
    color: "white"
    title: "Nonogram QtQuick"

    menuBar: MenuBar {
             Menu {
                 title: qsTr("&Game")
                 Action {
                     id: new_game_action
                     text: qsTr("&New Game")
                     onTriggered: new_game_dialog.open()
                 }
                 MenuSeparator { }
                 Action {
                     id: quit_action
                     text: qsTr("&Quit")
                     onTriggered: root.close()
                 }
             }
             Menu {
                 title: qsTr("&Help")
                 Action {
                     id: about_game_action
                     text: qsTr("&About Game")
                     onTriggered: about_dialog.open()
                 }
             }
         }

    Rectangle {
        width: 0.2 * parent.width
        height: parent.height
        color: "light grey"

        Button {
            id: check_button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            enabled: false
            width: 0.8 * parent.width
            height: 20
            text: "Check"
            onClicked: {
                lives_left_label.lives_left--
                mistakes_left_label.mistakes_left = nonogram_model.checkUserSolution()
                if (lives_left_label.lives_left == 0){
                    mistakes_left_label.mistakes_left == 0 ? you_won_dialog.open() : you_lost_dialog.open()
                    check_button.enabled = false
                } else if(mistakes_left_label.mistakes_left == 0){
                    you_won_dialog.open()
                    check_button.enabled = false
                }
            }

        }

        Label {
            anchors.centerIn: parent
            topPadding: -20
            text: "Mistakes left:"
        }

        Label {
            property int mistakes_left: 0
            id: mistakes_left_label
            anchors.centerIn: parent
            topPadding: 20
            text: mistakes_left
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            text: "Lives left:"
        }

        Label {
            property int lives_left: 0
            id: lives_left_label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text: lives_left
        }
    }

    Repeater {
        id: columns_description
        model: nonogram_model.columnDescription

        Text {
            x: 0.35 * root.width + (25 * index) + 7
            y: 0.23 * root.height - contentHeight
            text: modelData
        }
    }

    Repeater {
        id: rows_description
        model: nonogram_model.rowDescription

        Text {
            x: 0.32 * root.width - contentWidth
            y: 0.25 * root.height + (25 * index) + 5
            text: modelData
        }
    }

    Repeater {
        id: tile_repeater
        property int puzzle_size: nonogram_model.size
        model: puzzle_size * puzzle_size

        Rectangle {
            property var colors: ["white", "blue", "red"]
            id: tile
            width: 25
            height: width
            x: 0.35 * root.width + (width * (index % tile_repeater.puzzle_size))
            y: 0.25 * root.height + (height * ~~(index/tile_repeater.puzzle_size))
            color: "white"
            border.color: "black"
            border.width: 1

            NumberAnimation {
                id: tile_animation
                target: tile
                property: "rotation"
                from: 0
                to: 360
                duration: 10000
                loops: Animation.Infinite
            }

            MouseArea {
                anchors.fill : parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if (mouse.button == Qt.LeftButton) {
                        if (nonogram_model.getUserSolutionSpecific(modelData) == 1){
                            nonogram_model.setUserSolutionSpecific(modelData, 0)
                        } else {
                            nonogram_model.setUserSolutionSpecific(modelData, 1)
                        }
                    } else if (mouse.button == Qt.RightButton) {
                        if (nonogram_model.getUserSolutionSpecific(modelData) == 2){
                            nonogram_model.setUserSolutionSpecific(modelData, 0)
                        } else {
                            nonogram_model.setUserSolutionSpecific(modelData, 2)
                        }
                    }
                    parent.color = colors[nonogram_model.getUserSolutionSpecific(modelData)]
                }
            }
        }
    }

    New_game_dialog {
        id: new_game_dialog
        anchors.centerIn: parent
    }

    About_dialog {
        id: about_dialog
        anchors.centerIn: parent
    }

    NonogramModel {
        id: nonogram_model
    }

    Dialog {
        id: you_won_dialog
        anchors.centerIn: parent
        modal: true
        standardButtons: Dialog.Ok
        title: "Congratulations"
        Text {
            font.pixelSize: 16
            text: "You won!"
        }
    }

    Dialog {
        id: you_lost_dialog
        anchors.centerIn: parent
        modal: true
        standardButtons: Dialog.Ok
        title: "You lost"
        Text {
            font.pixelSize: 16
            text: "Good luck next time..."
        }
    }

}
