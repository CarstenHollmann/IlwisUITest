import QtQuick 2.0

Column {
    width: 200; spacing: 2


    Text {
        text: dimensions
        color: "#464E59"
        x : 25
        width: 200
        font.pixelSize: 11
        elide: Text.ElideMiddle
        //style: Text.Raised
        // styleColor: "black"
        maximumLineCount : 3

    }
}
