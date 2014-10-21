import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import "views" as Views
import "panel" as Panel
import MessageModel 1.0

ApplicationWindow {
    id : bigthing
    width: 1300
    height : 900
    color : "light grey"

    property int maxPull : 500


    property color background1 : "#EAECEE"
    property color background2 : "#DBDFE3"
    property color background3 : "#FFFDF4"
    property color background4 : "#EEEEEE"
    property int defaultFunctionBarWidth : 350
    property int activeCatalog: 0

    menuBar : MenuBar {
        id : mainMenu
        Menu {
            title: "Dummy 2"
            MenuItem { text: "Open..." }
            MenuItem { text: "Close" }
        }

        Menu {
            title: "Dummy 1"
            MenuItem { text: "Cut" }
            MenuItem { text: "Copy" }
            MenuItem { text: "Paste" }
        }
    }
    function transitionInfoPane(newpagename) {
        var changed1 = infoPContent1.source.toString().indexOf(newpagename) === -1;
        var changed2 = infoPContent2.source.toString().indexOf(newpagename) === -1;
        if ( changed1 && changed2) {
            var currentloader = infoPContent1.source == "" ? infoPContent2 : infoPContent1;
            var newloader = infoPContent1.source == "" ? infoPContent1 : infoPContent2;

            currentloader.z = 1
            newloader.z = 0

            currentloader.item.state = currentloader.item.state === "visible"  ? "invisible" : "visible";
            newloader.source = newpagename
        }else {
            infoP.state = infoP.state === "visible" ? "invisible" : "visible"
        }
    }



    function unloadcontent(newpagename) {
        if (infoPContent1.source.toString().indexOf(newpagename) != -1) {
            infoPContent1.source = ""
        } else  if (infoPContent2.source.toString().indexOf(newpagename) != -1) {
            infoPContent2.source = ""
        }
    }
    Rectangle {
        id : root
        anchors.fill : parent

    Rectangle {
        id : commLine;
        width : parent.width
        height : 32
        color : "#DDDDDD"
        TextField {
            id: t3
            anchors.fill: parent
            anchors.leftMargin: 5
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            anchors.rightMargin: 40
            placeholderText: "This is a placeholder for a TextField"
            width: 200
        }
    }



    Action {
        id : navClicked
        onTriggered : {
            transitionInfoPane("Navigator.qml")
          }

    }

    Action {
        id : operClicked
        onTriggered : {
            transitionInfoPane("OperationSelection.qml")
        }

    }
    Action {
        id : propertiesClicked
        onTriggered : {
            transitionInfoPane("ObjectProperties.qml")
        }

    }
    Action {
        id : messagesClicked
        onTriggered : {
            transitionInfoPane("MessagesPane.qml")
        }

    }
    Action {
        id : progressClicked
        onTriggered : {
            transitionInfoPane("Tranquilizers.qml")
        }

    }
    Action {
        id :maxButtons
        onTriggered: {
            buttonB.width = 55
        }
    }

    Action {
        id :minButtons
        onTriggered: {
            buttonB.width = 0
        }
    }



    SplitView {
        id : mainSplit
        orientation: Qt.Horizontal
        width: parent.width
        anchors.top : commLine.bottom
        height : bigthing.height - commLine.height * 2
        Rectangle {
            id : buttonB
            y : 0
            height : parent.height
            width : 55
            color : "#c2caca"
            border.width : 1
            Layout.maximumWidth : 120
            Column {
                anchors.fill: parent
                Rectangle {
                    height : 21
                    width : buttonB.width
                    color : background4
                    Row {
                        anchors.fill: parent
                        Button{
                            id : full
                            height : 20
                            width :20
                            action : maxButtons
                            Image { anchors.centerIn : parent; source: "images/max1.png" }
                        }
                        Button{
                            id : close
                            height : 20
                            width :20
                            action : minButtons
                            Image { anchors.centerIn : parent; source: "images/min1.png" }
                        }
                    }
                }

                Button{
                    id : nav
                    height : buttonB.width
                    width : buttonB.width
                    action: navClicked
                    Image { anchors.centerIn: parent;  source: "images/navigatorCS3.png" }
                    //Image {anchors.centerIn: parent; source: "images/navigatorCS2.png"}
                }
                Button{
                    id : oper
                    height : buttonB.width
                    width : buttonB.width
                    action: operClicked
                    Image { anchors.centerIn: parent;  source: "images/operationCS3.png" }
                }
                Button{
                    id : prop
                    height : buttonB.width
                    width : buttonB.width
                    action : propertiesClicked
                    Image { anchors.centerIn: parent; source: "images/propertiesCS3.png" }

                }
                Button{
                    id : errors
                    height : buttonB.width
                    width : buttonB.width
                    action : messagesClicked
                    Image { anchors.centerIn: parent; source: "images/"+ messagehandler.messageIcon }
                }
                Button{
                    id : progress
                    height : buttonB.width
                    width : buttonB.width
                    action : progressClicked
                    Image { anchors.centerIn: parent; source: "images/progress40.png" }

                }
                Button{
                    id : create
                    height : buttonB.width
                    width : buttonB.width
                    Image { anchors.centerIn: parent; source: "images/createCS3.png" }

                }
                Button{
                    id : config
                    height : buttonB.width
                    width : buttonB.width
                    Image { anchors.centerIn: parent; source: "images/configCS3.png" }

                }
            }
        }

        Rectangle {
            id : infoP

            width : defaultFunctionBarWidth
            color : background4
            Loader {
                id : infoPContent1
                y : 5
                x : 5
                width: infoP.width - 12
                height : parent.height - 15
            }

            Loader {
                id : infoPContent2
                y : 5
                x : 5
                width: infoP.width - 12
                height : parent.height - 15
            }

            Connections {
                 target: infoPContent1.item
                 onUnloadcontent: unloadcontent(content)
             }

            Connections {
                 target: infoPContent2.item
                 onUnloadcontent: unloadcontent(content)
             }

            states: [
                State { name: "visible"

                    PropertyChanges {
                        target: infoP
                        width : defaultFunctionBarWidth
                    }
                },
                State {
                    name : "invisible"
                    PropertyChanges {
                        target: infoP
                        width : 0
                    }
                }

            ]
            transitions: [
                Transition {
                    NumberAnimation { properties: "width"; duration : 750 ; easing.type: Easing.InOutCubic }
                }
            ]
            Component.onCompleted: {
            }


        }



        Rectangle {
            id: centerItem
            color: background4
            height : parent.height - 16
            width : bigthing.width - buttonB.width - infoP.width - 5
            TabView {
                anchors.fill : parent
                id : tabs
                   Tab {
                    id : catalog_0
                    title : "World"
                    Panel.CatalogPanel{
                    }
                }
            }
        }
        Component.onCompleted: { infoPContent1.source = "Navigator.qml"}
    }

    Rectangle {
        id : blankFrame
        x : 0
        y : 0
        width : bigthing.width
        height: bigthing.height
        color : "black"
        opacity : 0.0
    }
    }

    statusBar: StatusBar {
        id : statusB
        RowLayout {
            Label { text: "Read Only" }
            Label { text: "More text" }
        }
    }
}
