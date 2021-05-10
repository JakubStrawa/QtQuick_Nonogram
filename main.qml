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
            width: 0.8 * parent.width
            height: 20
            text: "Check"
            onClicked: {
                lives_left_label.lives_left--
                mistakes_left_label.mistakes_left = nonogram_model.checkUserSolution()
                console.log(nonogram_model.userSolution)
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
        //model: ["3\n2", "5", "1\n1\n1\n1\n1\n1", "3\n2", "5", "1\n1\n1", "3\n2", "5", "1\n1\n1", "2\n1\n2\n1"]
        model: nonogram_model.columnDescription

        Text {
            x: 0.35 * root.width + (25 * index) + 7
            y: 0.23 * root.height - contentHeight
            text: modelData
        }
    }

    Repeater {
        id: rows_description
        //model: ["3 2", "5", "1 1 1 1 1 1", "3 2", "5", "1 1 1", "3 2", "5", "1 1 1", "2 1 2 1"]
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
                        if (Qt.colorEqual(parent.color, "blue")){
                            parent.color = "white"
                            nonogram_model.setUserSolutionSpecific(modelData, 0)
                        } else {
                            parent.color = "blue"
                            nonogram_model.setUserSolutionSpecific(modelData, 1)
                        }
                    } else if (mouse.button == Qt.RightButton) {
                        if (Qt.colorEqual(parent.color, "red")){
                            parent.color = "white"
                        } else {
                            parent.color = "red"
                            nonogram_model.setUserSolutionSpecific(modelData, 0)
                        }
                    }
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


}
