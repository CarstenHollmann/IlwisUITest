import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import MasterCatalogModel 1.0
import VisualizationManager 1.0
import "../controls" as Controls

Rectangle {
    id : visualizationFormContainer

    signal unloadcontent(string content)

    color : background4
    clip : true
    state : "invisible"
    height : 500
    opacity : 1

    FunctionBarHeader{
        id : functionBarHeader
        headerImage: "../images/visualization40.png"
        headerText:"Visualization"
        z : 1
    }

    Image {
        anchors.fill: parent
        source : "images/back2.png"
        opacity : 0.5
        smooth : true
    }




    ListModel {
        id : dummyMaps
        ListElement {
            displayName : "GCL_INT__12.mpr"
            imagePath: "images/raster20.png"
            type : "rastercoverage"
        }
        ListElement {
            displayName : "woredas.shp"
            imagePath: "images/feature20.png"
            type : "featurecoverage"
        }
        ListElement {
            displayName : "average_monthly_temperature_june_7.mpr"
            imagePath: "images/raster20.png"
            type : "rastercoverage"
        }

    }

    ListModel {
        id: globalPropertiesList
        ListElement {
            label : "3D"
            icon: "images/threeD.ico"
            editor : "rastercoverage"
        }
        ListElement {
            label : "DistanceMeasurer"
            icon: "images/measurer.ico"
            editor : "featurecoverage"
        }
        ListElement {
            label : "Geometry"
            icon: "images/csy.ico"
            editor : "featurecoverage"
        }
        ListElement {
            label : "Grid"
            icon: "images/grid.ico"
            editor : "featurecoverage"
        }
        ListElement {
            label : "Gratticule"
            icon: "images/grat.ico"
            editor : "featurecoverage"
        }
    }

    ListModel {
        id: representationList
        ListElement {
            label : "Single color"
            icon: "images/singlecolor.ico"
            type : "rastercoverage"
        }
        ListElement {
            label : "Multiple colors"
            icon: "images/multiplecolors.ico"
            type : "featurecoverage"
        }
        ListElement {
            label : "Representation"
            icon: "images/rpr.ico"
            type : "featurecoverage"
        }
    }

    ListModel {
        id: visibilityList
        ListElement {
            label : "Visibility"
            icon: "images/mapview.bmp"
            type : "rastercoverage"
        }
        ListElement {
            label : "Labels"
            icon: "images/atx.ico"
            type : "featurecoverage"
        }
        ListElement {
            label : "Selections"
            icon: "images/select.ico"
            type : "featurecoverage"
        }
    }

    Rectangle {
        id : layerSelectionBar
        height : 170
        anchors.top : functionBarHeader.bottom
        anchors.topMargin: 3
        width : functionBarHeader.width
        x : functionBarHeader.x
        color : background2
        Column {
            spacing : 6
            width : parent.width
            height : parent.height
            Column {
                id : layerSelectionColumn
                width : parent.width
                height : 80
                Text {
                    id : headerLayerSelection
                    text : qsTr("Layer Selection")
                    font.bold: true
                    font.pointSize: 10
                }
                Rectangle {
                    width : parent.width - 6
                    x : 3
                    height :layerSelectionColumn.height - headerLayerSelection.contentHeight
                    color : background1
                    radius : 10

                    ListView{
                        id : layers
                        anchors.fill : parent

                        model : dummyMaps
                        focus : true
                        clip : true
                        delegate {
                            Item {
                                width : parent.width
                                height : 18
                                Row {
                                    width : parent.width
                                    height : parent.height
                                    spacing : 3
                                    Image {
                                        source : imagePath
                                        width : 13
                                        fillMode: Image.PreserveAspectFit
                                        anchors.verticalCenter: parent.verticalCenter

                                    }
                                    CheckBox{
                                        width : 20
                                        checked : true
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Text  {
                                        id : dnText
                                        text : displayName
                                        font.pointSize: 9
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                MouseArea {
                                    hoverEnabled: true
                                    anchors.fill: parent
                                    cursorShape: Qt.ArrowCursor
                                    onClicked: {
                                        layers.currentIndex = index
                                        //                                    var visualization = visualizationmanager.layer(0,layers.currentIndex)
                                        //                                    if ( visualization != null)
                                        //                                        properties.model = visualization.properties
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Controls.CollapsiblePanel{
                 id : globProps
                 width : parent.width
                 panelHeight : 80
                 state : "collapsed"
                 titleText : qsTr("Global Properties")

                 VisualizationProperties{
                     model : globalPropertiesList
                 }

                 clip : true

             }
             Controls.CollapsiblePanel{
                 width : parent.width
                 panelHeight : 60
                 state : "collapsed"
                 titleText : qsTr("Colors")
                 VisualizationProperties{
                     model : representationList
                 }
             }
             Controls.CollapsiblePanel{
                 width : parent.width
                 panelHeight : 60
                 state : "collapsed"
                 titleText : qsTr("Visibility")

                 VisualizationProperties{
                     model : visibilityList
                 }
             }


        }
    }
    Loader {
        id : form1
        y : 5
        x : 5
        width: parent.width

    }





    states: [
        State { name: "visible"

            PropertyChanges {
                target: visualizationFormContainer
                opacity : 1
            }
        },
        State {
            name : "invisible"
            PropertyChanges {
                target: visualizationFormContainer
                opacity : 0
            }
        }

    ]
    transitions: [
        Transition {
            NumberAnimation {
                properties: "opacity"; duration : 500 ; easing.type: Easing.Linear
            }
            onRunningChanged :
            {
                if ( opacity == 0) {
                    unloadcontent("Visualization.qml")
                }
            }

        }
    ]
}

