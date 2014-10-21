import QtQuick 2.1

Rectangle {
    id: contextPanel
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "grey";
        }
        GradientStop {
            position: 1.00;
            color: "white";
        }
    }

    property alias titleText: titleTxt.text
    property alias customModel: listView.model
    property alias customDelegate: listView.delegate
    property alias view : listView

    Rectangle{
        id: titleRect
        width: parent.width
        height: 26
        color : "#A9A9A9"
        Image {
            id: titleArrow
            width:  15
            height:  15
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            source: "../images/arrowdown.png"

        }
        Text{
            id: titleTxt
            anchors.left: titleArrow.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
            color:  "#8B0000"
            font.bold: true
        }
        MouseArea{
            width: parent.width
            height:  parent.height
            onClicked: {
                if (contextPanel.state == "collapsed")
                {
                    contextPanel.state = ""
                }
                else
                {
                    contextPanel.state = "collapsed"
                }
            }
        }
    }

    ListView{
        id: listView
        width: parent.width
        height: parent.height-titleRect.height
        anchors.top: titleRect.bottom
        model: customModel
        delegate: customDelegate

        focus: true
        highlight: Rectangle {
            width: parent.width
            height: parent.height-titleRect.height
            color: "#f13a3a"
        }

    }

    states: [
        State {
            name: "collapsed"
            PropertyChanges {
                target: listView
                height: 0
                opacity: 0
            }
            PropertyChanges {
                target: contextPanel
                height: titleRect.height
            }
            PropertyChanges {
                target: titleArrow
                rotation: -90
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { target: listView; property: "height"; duration: 300 }
            NumberAnimation { target: listView; property: "opacity"; duration: 300 }
            NumberAnimation { target: titleArrow; property: "rotation"; duration: 300 }
        }
    ]

    Component.onCompleted:  {
        contextPanel.height = titleRect.height+listView.contentHeight
    }
}
