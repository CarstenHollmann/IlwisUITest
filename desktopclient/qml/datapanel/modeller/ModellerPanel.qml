import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import MasterCatalogModel 1.0
import "../catalog" as Parent

Item {
    property int heightButtons : 26
    id : modellerViews
    width : parent.width
    height : parent.height

    signal modellerChanged()

    ToolBar{
        id : toolbar
        anchors.top : parent.top
        width : parent.width
        //height : 35

        Action {
            id :refreshCatalog
            onTriggered: {
                //canvas.clear();
            }
        }

        Action {
            id :zoomInAction
            onTriggered: {
                //canvas.zoomIn();
            }
        }

        Action {
            id :zoomOutAction
            onTriggered: {
               // canvas.zoomOut();
            }
        }

        RowLayout{
            spacing: 1

            ToolButton{
                id : zoomIn
                height: toolbar.height
                //iconSource: "../../images/plus.png"
                Image {
                    source: "../../images/plus.png"
                    anchors.fill: parent
                    anchors.margins: 4
                }
                checkable: true
                action: zoomInAction
            }
            ToolButton{
                id : zoomOut
                height: toolbar.height
                //iconSource: "../../images/minus.png"
                Image {
                    source: "../../images/minus.png"
                    anchors.fill: parent
                    anchors.margins: 4
                }
                checkable: true
                action: zoomOutAction
            }

            ToolButton{
                id : refresh
                implicitHeight: heightButtons
                iconSource: "../../images/refresh20.png"
                tooltip: "Refresh"
                action : refreshCatalog
            }

        }

    }

    Rectangle {
        width : parent.width
        anchors.top: toolbar.bottom
        anchors.bottom: parent.bottom
        color: "white"

        DataSource {

        }

        Operation {

        }


//        Drawing {
//            id:canvas
//            width:parent.width
//            height:parent.height
//            anchors.margins:-2
//            x:-3
//            y:-3
//        }
    }

//-------------------------------------------
//    Item {
//        id : catalogView
//        width : parent.width
//        anchors.top: toolbar.bottom
//        anchors.bottom: parent.bottom
//        Connections{
//            target : iconListView
//            onShowObject : { showObject(objectid)}
//        }

//        Parent.CatalogGrid{
//            id : iconGridView
//            height : 0
//            enabled : false
//        }


//        states: [
//            State {
//                name : "iconGrid"
//                PropertyChanges { target: thumbListView; height : 0; opacity : 0; enabled : false}
//                PropertyChanges { target: iconListView; height : 0; opacity : 0;enabled : false}
//                PropertyChanges { target: iconGridView; height : parent.height; opacity : 1;enabled : true}
//            },
//            State {
//                name : "thumbList"
//                PropertyChanges { target: thumbListView; height : parent.height;opacity : 1; enabled : true}
//                PropertyChanges { target: iconListView; height :0; opacity : 0;enabled : false}
//                PropertyChanges { target: iconGridView;  height : 0; opacity : 0;enabled : false}
//            },
//            State {
//                name : "iconList"
//                PropertyChanges { target: thumbListView; height : 0; opacity : 0;enabled : false}
//                PropertyChanges { target: iconListView; height : parent.height;opacity : 1; enabled : true}
//                PropertyChanges { target: iconGridView;  height : 0; opacity : 0;enabled : false}
//            }

//        ]

//        transitions: [
//            Transition {
//                ParallelAnimation{
//                    NumberAnimation { target: thumbListView; properties: "height"; duration: 400; easing.type: Easing.InOutQuad }
//                    NumberAnimation { target: thumbListView; properties: "opacity"; duration: 400; easing.type: Easing.InOutQuad }
//                }
//                ParallelAnimation{
//                    NumberAnimation { target: iconListView; property: "height"; duration: 400; easing.type: Easing.InOutQuad }
//                    NumberAnimation { target: iconListView; property: "opacity"; duration: 400; easing.type: Easing.InOutQuad }
//                }
//                ParallelAnimation{
//                    NumberAnimation { target: iconGridView; property: "height"; duration: 400; easing.type: Easing.InOutQuad }
//                    NumberAnimation { target: iconGridView; property: "opacity"; duration: 400; easing.type: Easing.InOutQuad }
//                }
//            }
//        ]
//    }

}
