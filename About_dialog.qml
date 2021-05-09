import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Dialog {
    id: about_dialog
    standardButtons: Dialog.Ok
    title: "About game"
    Text {
        font.pixelSize: 10
        text: "Hello!\nNonogram (also known as 'Paint By Numbers', 'Japanese Crossword', 'Griddler', 'CrossPix' or 'Hanjie')
is a puzzle where it is necessary to draw an image in accordance with the numbers outside the grid.
The image is made up of blue and white/red squares. The numbers indicate how many
groups of blue squares are in each row or column. For example in 15x15 puzzle
if a row is described by '1 3 5' we have 3 groups of blue squares containing 1, 3 and 5 blue squares,
so 9 blue squares in total in that row. Same applies to columns. Each group of blue squares
has to be separated by at least 1 white/red square.
\nClick LMB to change its colot to blue or RMB to chnage it to red.
Use red to paint tiles which you think are not blue ones.\n\nTo see your result press \"Check\" button.\nHave fun!"
    }

}
