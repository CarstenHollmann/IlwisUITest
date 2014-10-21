import QtQuick 2.0

Rectangle {
    radius : 3
    border.width: 1
    border.color: "#686868"
    gradient: Gradient {
        GradientStop { position: 0 ; color: control.checked ? "#ccc" : "#eee" }
        GradientStop { position: 1 ; color: control.checked ? "#aaa" : "#ccc" }
    }
}
