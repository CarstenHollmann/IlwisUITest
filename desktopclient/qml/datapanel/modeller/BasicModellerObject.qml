import QtQuick 2.0
import QtQuick.Controls 1.0
import "modeller.js" as Code

Rectangle {
    border.color : "black"
    color: "#EAECEE"

    property string nameText

    Text {
        id: name
        text: qsTr(nameText)
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        rotation: -parent.rotation
    }

    MouseArea {
        anchors.fill: parent
         hoverEnabled:true
         onPressed: Code.startMoveItem(mouse, parent);
         onPositionChanged: Code.continueMoveItem(mouse);
         onReleased: {
             Code.endMoveItem(mouse);
         }
         onEntered: parent.opacity = 0.5;
         onExited:  parent.opacity = 1;
    }
}
