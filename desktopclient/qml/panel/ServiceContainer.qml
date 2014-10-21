import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Dialogs 1.0
import "../views" as Views

Rectangle {
    id : serviceContainer
    property color background1 : "#EAECEE"
    property color background2 : "#E2E6E9"
    property color background3 : "#EAECEE"
    property int defaultHeight : 0

    opacity : 1
    height : 0
    color : background1
    border.width: 1
    clip : true
    state : "visible"

    Text {
        id : title
        x : 10
        y : 5
        font.bold : true

        text : "Available Services"
    }

    Row {
        id : buttons
        anchors.top : title.bottom
        anchors.margins: 3
        Button{
            id : addContainer
            width : 40
            height : 40
            Image { anchors.centerIn: parent;source: "../images/plus.png"; width : 30; height : 30 }

        }
        Button{
            id : removeContainer
            width : 40
            height : 40
            Image { anchors.centerIn: parent;source: "../images/minus.png"; width : 30; height : 30 }

        }
    }

    Rectangle {
        id : servicesRect
        anchors.top : buttons.bottom
        //anchors.bottom: parent.bottom
        height: parent.height * 0.3
        anchors.bottomMargin: 65
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 5
        x : 5
        width: parent.width - 10
        color : background2

        ListModel {
            id : serviceModel
            ListElement { servicename : "dummy" }
        }


        ListView{
            id : currentServices
            model : serviceModel
            width : parent.width
            height : parent.height - 65
            x : 5
            clip : true

            delegate : Item {
                height : 20
                width : parent.width - 15
                Rectangle {
                    anchors.fill: parent
                    color: currentServices.currentIndex == index ? "red" : index  % 2 == 0 ? background2 : background3
                    opacity : currentServices.currentIndex == index ? 0.2 : 1
                }

                Text{
                    text : model.servicename
                    elide : Text.ElideRight
                    maximumLineCount: 1
                }

                MouseArea {
                    hoverEnabled: true
                    anchors.fill: parent
                    cursorShape: Qt.ArrowCursor
                    onClicked: {
                        currentServices.currentIndex = index;
                    }


                }
            }
        }
    }

    Rectangle {
        id : properties
        x : 5
        width : parent.width - 10
        anchors.top : servicesRect.bottom
        anchors.margins: 6
        height : 100
        color : background1
        ColumnLayout {
            anchors.fill: parent
            Text {
                id : propTitle
                text : "Properties"
                font.bold : true
            }
            TextField  {
                placeholderText: "Human readable alias"
                Layout.minimumWidth: servicesRect.width
            }
            Text {
                id : urlTitle
                text : "Definition"
            }

            TextArea {
                Layout.minimumWidth: servicesRect.width
                Layout.maximumHeight: parent.height  -propTitle.height - urlTitle.height
            }
            Text {
                id : descTitle
                text : "Description"
            }

            TextArea {
                Layout.minimumWidth: servicesRect.width
                Layout.maximumHeight: parent.height  -propTitle.height - urlTitle.height
            }
        }

    }

    states: [
        State { name: "visible"

            PropertyChanges {
                target: serviceContainer
                opacity : 1
                z : 0
                height : defaultHeight
            }
        },
        State {
            name : "invisible"
            PropertyChanges {
                target: serviceContainer
                defaultHeight : height
                opacity : 0
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation
            { id : opatrans; properties: "opacity"; duration : 500 ; easing.type: Easing.OutCubic
                onRunningChanged: {
                        console.log(height)
                    if ( !opatrans.running ){
                        height = opacity == 0 ? 0 : defaultHeight
                        if ( opacity == 0)
                            z = -1
                    }
                }
            }

        }
    ]
}

