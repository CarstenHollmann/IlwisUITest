import QtQuick 2.0

BorderImage {
    property string headerImage
    property string headerText

    id : title
    height : 30
    anchors.left: parent.left
    width : parent.width

    border { left: 15; top: 0; right: 15; bottom: 0 }
    smooth : true
    y : 5
    source : "../images/headergreen.png"
    Rectangle {
        id : idBackground
        anchors.verticalCenter: parent.verticalCenter
        x : 5
        width: 19
        height : 19
        color : "white"
        Image {
            id : icon
            x : -2
            source: headerImage
            anchors.verticalCenter: parent.verticalCenter
            width : 28
            height : 28
        }
    }
    Text {
        x : 35
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        text : headerText
        font.pointSize: 12
    }
}
