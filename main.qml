import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: root
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

    About_dialog {
        id: about_dialog
        anchors.centerIn: parent
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

    Column {
        id: column_puzzle
        property int sizePuzzle: 5
        x: 0.35 * root.width
        y: 0.15 * root.height
        Repeater {
            model: column_puzzle.sizePuzzle
            Row {
                Repeater {
                    model: column_puzzle.sizePuzzle
                    Rectangle {
                        width: 30
                        height: width
                        color: "white"
                        border.color: "black"
                        border.width: 2

                        MouseArea {
                            anchors.fill : parent
                            onClicked: {
                                if (parent.color == "blue") {
                                    parent.color = "white"
                                } else {
                                    parent.color = "blue"
                                }


                            }
                        }
                    }
                }
            }
        }
    }


}
