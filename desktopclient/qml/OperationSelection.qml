import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import "views" as Views
import "panel" as Panel
import MasterCatalogModel 1.0
import OperationCatalogModel 1.0
import OperationModel 1.0
import ApplicationFormExpressionParser 1.0

Rectangle {
    id : container

    property int defaultWidth: defaultFunctionBarWidth
    property var currentAppForm : null
    property var operationid

    color : background4
    clip : true
    width : defaultWidth
    state : "visible"
    opacity : 0

    signal unloadcontent(string content)

    function makeForm(metaid, title){
        var form= formbuilder.index2Form(metaid)
        appFrame.formQML = form
        appFrame.formTitle = title
    }

    Panel.FunctionBarHeader{
        id : functionBarHeader
        headerImage: "../images/operationCS3.png"
        headerText:"Operations"
    }

     Rectangle {
        id : searchBar
        height : 56
        anchors.top : functionBarHeader.bottom
        anchors.topMargin: 3
        width : functionBarHeader.width
        x : functionBarHeader.x
        color : background2
        Column {
            anchors.fill: parent
            Item{
                height : 22
                width : parent.width
                Text {
                    id : searchTextLabel
                    height : 20
                    text : "Filter Text"
                    width : keywordsLabel.width
                    y : 4
                    x: 5
                }
                TextField {
                    id : searchText
                    anchors.left: searchTextLabel.right
                    height : 20
                    width : parent.width - searchTextLabel.width - 9
                }
            }
            Item {
                height : 22
                width : parent.width
                Text {
                    id : keywordsLabel
                    //anchors.top : searchTextLabel.bottom
                    x : 5
                    height : 20
                    text : "Keyword search "
                }
                ComboBox {
                    anchors.left: keywordsLabel.right
                    //anchors.top : searchText.bottom
                    height : 20
                    width : parent.width - searchTextLabel.width  - 9
                    editable: true
                }
            }
        }


    }

    SplitView{
        width : parent.width
        anchors.bottom: container.bottom
        anchors.top : searchBar.bottom;
        anchors.topMargin: 5
        orientation: Qt.Vertical
        Rectangle {
            id : applicationForm
            width : parent.width
            height : 0
            x : parent.x + 5

            Panel.ApplicationForm{
                id : appFrame
                width : parent.width
                height : parent.height - 30 < 0 ?  0 : parent.height - 30

            }
            Button{
                y : parent.height - 25
                width : 50
                text : "execute"
                height : 22
                x : parent.width - 60
                onClicked: appFrame.doExecute(operationid)
            }
            states: [
                State { name: "maximized"

                    PropertyChanges {
                        target: applicationForm
                        height : 300
                        opacity : 1

                    }
                },
                State {
                    name : "minimized"
                    PropertyChanges {
                        target: applicationForm
                        height : 0
                        opacity : 0
                    }
                }

            ]
            transitions: [
                Transition {
                    NumberAnimation { properties: "height"; duration : 750 ; easing.type: Easing.InOutCubic }
                    NumberAnimation { properties: "opacity"; duration : 750 ; easing.type: Easing.InOutCubic }
                }
            ]
        }

        Rectangle {
            //anchors.top : applicationForm.bottom
            width : parent.width
            color : "white"
            clip : true
            ListView {
                id : operationsList
                anchors.fill: parent
                model : operations.operations
                delegate : Item{
                    id : currentOperation
                    height : 35;
                    width : parent.width;
                    Rectangle {
                        anchors.fill: parent
                        color: operationsList.currentIndex === index ? "#00BFFF" : index  % 2 == 0 ? "#FFFCE6" : "#DCDCDC"
                        radius : 5
                        Text {
                            id : operationName
                            text : displayName
                            anchors.top : parent.top
                            width : parent.width
                            height : 17
                            x : 5
                            font.pointSize: 12
                        }
                        Text {
                            id : operationSyntax
                            text : syntax()
                            anchors.top : operationName.bottom
                            width : parent.width
                            height : 12
                            font.pointSize: 8
                            x : 5
                            color : "grey"
                        }
                    }

                    focus : true
                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: Qt.ArrowCursor
                        onClicked: {
                            applicationForm.state = operationsList.currentIndex == index && applicationForm.state != "minimized" ? "minimized" : "maximized"
                            operationsList.currentIndex = index;
                            operationid = operations.operationId(index)
                            makeForm(operationid, displayName);
                        }
                    }

                }

            }
        }
    }

    states: [
        // This adds a second state to the container where the rectangle is farther to the right

        State { name: "visible"

            PropertyChanges {
                target: container
                opacity : 1
            }
        },
        State {
            name : "invisible"
            PropertyChanges {
                target: container
                opacity : 0
            }
        }

    ]
    transitions: [
        Transition {
            NumberAnimation { properties: "opacity"; duration : 500 ; easing.type: Easing.Linear }
            onRunningChanged :
            {
                if ( opacity == 0) {
                    unloadcontent("OperationSelection.qml")
                }
            }
        }


    ]

}
