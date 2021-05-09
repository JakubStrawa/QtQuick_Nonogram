import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Dialog {
    id: new_game_dialog
    title: "New game"
    Column {
        anchors.centerIn: parent
        spacing: 10
        ComboBox {
            id: size_combo_box
            model: ["5x5", "10x10", "15x15"]
        }
        ComboBox {
            id: theme_combo_box
            model: ["Animals", "Vehicles", "Items"]
        }
        SpinBox {
            id: lives_spin_box
            from: 1
            to: 99
            value: 3
        }
    }

    standardButtons: Dialog.Ok | Dialog.Cancel

    onAccepted: {
        tile_repeater.puzzle_size = size_combo_box.currentIndex*5 + 5
        mistakes_left_label.text = "Press Check"
        lives_left_label.text = lives_spin_box.value
    }
}
