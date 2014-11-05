import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0


Rectangle {
    id : buttonB
    y : 0
    height : parent.height
    width : 55
    color : "#c2caca"
    border.width : 1
    Layout.maximumWidth : 120

    //signal transitionInfoPane(string pagename)

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
        id : modellerClicked
        onTriggered : {
            transitionInfoPane("Modeller.qml")
        }

    }
    Action {
        id :maxButtons
        onTriggered: {
            buttonB.width = 55
        }
    }

    Action {
        id :visualizerClicked
        onTriggered: {
            transitionInfoPane("Visualization.qml")
        }
    }

    Action {
        id :minButtons
        onTriggered: {
            buttonB.width = 0
        }
    }

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
                    Image { anchors.centerIn : parent; source: "../images/max1.png" }
                }
                Button{
                    id : close
                    height : 20
                    width :20
                    action : minButtons
                    Image { anchors.centerIn : parent; source: "../images/min1.png" }
                }
            }
        }

        Button{
            id : nav
            height : buttonB.width
            width : buttonB.width
            action: navClicked
            tooltip: "Navigate to the data source"
            Image { anchors.centerIn: parent;  source: "../images/navigatorCS3.png" }
        }

        Button{
            id : oper
            height : buttonB.width
            width : buttonB.width
            action: operClicked
            Image { anchors.centerIn: parent;  source: "../images/operationCS3.png" }
        }
        Button{
            id : modeller
            height : buttonB.width
            width : buttonB.width
            action: modellerClicked
            Image { anchors.centerIn: parent;  source: "../images/modeller40.png" }
        }
        Button{
            id : visualize
            height : buttonB.width
            width : buttonB.width
            action: visualizerClicked
            enabled : false
            Image { anchors.centerIn: parent;  source: visualize.enabled ?  "../images/visualization40.png" : "../images/visualizationdisabled40.png"}
        }
        Button{
            id : prop
            height : buttonB.width
            width : buttonB.width
            action : propertiesClicked
            Image { anchors.centerIn: parent; source: "../images/properties40.png" }

        }
        Button{
            id : errors
            height : buttonB.width
            width : buttonB.width
            action : messagesClicked
            Image { anchors.centerIn: parent; source: "../images/"+ messagehandler.messageIcon }
        }
        Button{
            id : progress
            height : buttonB.width
            width : buttonB.width
            action : progressClicked
            Image { anchors.centerIn: parent; source: "../images/progress40.png" }

        }
        Button{
            id : create
            height : buttonB.width
            width : buttonB.width
            Image { anchors.centerIn: parent; source: "../images/createCS3.png" }

        }
        Button{
            id : config
            height : buttonB.width
            width : buttonB.width
            Image { anchors.centerIn: parent; source: "../images/configCS3.png" }

        }
    }
}
