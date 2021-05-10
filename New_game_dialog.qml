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
        mistakes_left_label.mistakes_left = -1
        lives_left_label.lives_left = lives_spin_box.value
        nonogram_model.setTheme(theme_combo_box.currentText)
        nonogram_model.setSize(5 + 5*(size_combo_box.currentIndex))
        check_button.enabled = true
        for (var i=0; i<tile_repeater.count; i++){
            tile_repeater.itemAt(i).color = "white"
        }
    }
}
