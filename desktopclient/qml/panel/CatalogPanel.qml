import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import MasterCatalogModel 1.0

Item {
    property int heightButtons : 26
    id : catalogViews
    width : parent.width
    height : parent.height

    signal catalogChanged()

    function toggleFilter(objecttype, togglestate){
        mastercatalog.setObjectFilterCurrentCatalog(objecttype, togglestate)
        catalogChanged()
    }

    ToolBar{
        id : toolbar
        anchors.top : parent.top
        width : parent.width
        //height : 35

        RowLayout{
            spacing: 1
            ExclusiveGroup { id : catalogViewStatus
                onCurrentChanged: {
                    if( showList.checked)
                        catalogView.state = "iconList"
                    if ( showGrid.checked)
                        catalogView.state = "iconGrid"
                    if ( showThumbs.checked)
                        catalogView.state = "thumbList"
                }
            }

            ToolButton{
                id : showList
                implicitHeight: heightButtons
                iconSource: "images/list20.png"
                checkable: true
                checked: true
                exclusiveGroup: catalogViewStatus
            }
            ToolButton{
                id : showGrid
                implicitHeight: heightButtons
                iconSource: "images/grid20.png"
                checkable: true
                checked: false
                exclusiveGroup: catalogViewStatus
            }
            ToolButton{
                id : showThumbs
                implicitHeight: heightButtons
                iconSource: "images/thumblist20.png"
                checkable: true
                checked: false
                exclusiveGroup: catalogViewStatus
            }

            Rectangle{
                implicitHeight: heightButtons
                width: 10
                color : "grey"
                opacity: 0
            }

            ToolButton{
                id : refresh
                implicitHeight: heightButtons
                iconSource: "images/refresh20.png"
                tooltip: "Refresh"
            }

            Rectangle{
                implicitHeight: heightButtons
                width: 20
                color : "grey"
                opacity: 0
            }

            CheckBox{
                id : allSelected
                checkedState: Qt.Checked
                implicitHeight: heightButtons
            }

            ToolButton{
                id : showRasters
                implicitHeight: heightButtons
                iconSource: "images/raster20.png"
                checkable: true
                checked: true
                onClicked: toggleFilter("rastercoverage", checked);
            }
            ToolButton{
                id : showFeatures
                implicitHeight: heightButtons
                iconSource: "images/feature20.png"
                checkable: true
                checked: true
                onClicked: toggleFilter("featurecoverage", checked);
            }
            ToolButton{
                id : showTables
                implicitHeight: heightButtons
                iconSource: "images/table20.png"
                checkable: true
                checked: true
                onClicked: toggleFilter("table", checked);
            }
            ToolButton{
                id : showCsys
                implicitHeight: heightButtons
                iconSource: "images/csy20.png"
                checkable: true
                checked: true
                onClicked: toggleFilter("coordinatesystem", checked);
            }
            ToolButton{
                id : showGrfs
                implicitHeight: heightButtons
                iconSource: "images/georeference20.png"
                checkable: true
                checked: true
                onClicked: toggleFilter("georeference", checked);
            }
            ToolButton{
                id : showDomains
                implicitHeight: heightButtons
                iconSource: "images/domain.png"
                checkable: true
                checked: true
                onClicked: toggleFilter("domain", checked);
            }
        }


    }
    Item {
        id : catalogView
        width : parent.width
        anchors.top: toolbar.bottom
        anchors.bottom: parent.bottom
        CatalogGrid{
            id : iconGridView
            height : 0
            enabled : false
            opacity : 0
        }
        CatalogList{
            id : iconListView
            height : parent.height
        }
        CatalogThumbList{
            id : thumbListView
            height : 0
            enabled : false
            opacity: 0

        }

        states: [
            State {
                name : "iconGrid"
                PropertyChanges { target: thumbListView; height : 0; opacity : 0; enabled : false}
                PropertyChanges { target: iconListView; height : 0; opacity : 0;enabled : false}
                PropertyChanges { target: iconGridView; height : parent.height; opacity : 1;enabled : true}
            },
            State {
                name : "thumbList"
                PropertyChanges { target: thumbListView; height : parent.height;opacity : 1; enabled : true}
                PropertyChanges { target: iconListView; height :0; opacity : 0;enabled : false}
                PropertyChanges { target: iconGridView;  height : 0; opacity : 0;enabled : false}
            },
            State {
                name : "iconList"
                PropertyChanges { target: thumbListView; height : 0; opacity : 0;enabled : false}
                PropertyChanges { target: iconListView; height : parent.height;opacity : 1; enabled : true}
                PropertyChanges { target: iconGridView;  height : 0; opacity : 0;enabled : false}
            }

        ]

        transitions: [
            Transition {
                ParallelAnimation{
                    NumberAnimation { target: thumbListView; properties: "height"; duration: 400; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: thumbListView; properties: "opacity"; duration: 400; easing.type: Easing.InOutQuad }
                }
                ParallelAnimation{
                    NumberAnimation { target: iconListView; property: "height"; duration: 400; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: iconListView; property: "opacity"; duration: 400; easing.type: Easing.InOutQuad }
                }
                ParallelAnimation{
                    NumberAnimation { target: iconGridView; property: "height"; duration: 400; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: iconGridView; property: "opacity"; duration: 400; easing.type: Easing.InOutQuad }
                }
            }
        ]
    }

}
