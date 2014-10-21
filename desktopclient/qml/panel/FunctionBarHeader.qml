import QtQuick 2.0

Rectangle {
    property string headerImage
    property string headerText

    id : title
    height : 30
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: 5
    y : 5
    color : background1
    border.width: 1
    Image {
        id : icon
        source: headerImage
        anchors.verticalCenter: parent.verticalCenter
        x : 5
        width : 28
        height : 28
    }
    Text {
        anchors.left: icon.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        text : headerText
        font.pointSize: 12
    }
}
