import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick 2.0

Rectangle {
    property color background1 : "#EAECEE"
    property string formQML : ""
    property var currentAppForm : null
    property string formTitle : "est"

    id : applicationFormFrame
    width : parent.width
    height : parent.height
    radius : 10
    color : background1

    function doExecute(operationid) {
        if ( currentAppForm != null) {
            operations.executeoperation(operationid,currentAppForm.formresult)
        }
    }

    onFormQMLChanged: {
        if ( currentAppForm != null){
            currentAppForm.destroy(0)
        }

        if ( formQML.length !== 0) {
            currentAppForm = Qt.createQmlObject(formQML,
                applicationArea, "autoform1");
        }
    }

    Column {
        anchors.fill: parent
        spacing : 3
        Rectangle {
            id : title
            width: parent.width
            height : 25
            color : "#9EB0C8"
            Text  {
                text : formTitle
                font.pointSize: 11
                x : 5
            }
        }
        Rectangle {
            id : applicationArea
            property string exprparameters
            width : parent.width
            height : parent.height - applicationFormFrame.height - 20
        }
    }
}
