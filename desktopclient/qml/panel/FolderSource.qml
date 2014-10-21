import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Dialogs 1.0
import "../views" as Views
import "../panel" as Panel
import MasterCatalogModel 1.0

Rectangle {
    id : navigationFoldercreate
    property color background : "#FFF9E3"
    property color listbackground : "white"
    property color listalternate : "#9B9B9E"
    property int defaultHeight : 0
    property var bookmarkModel: mastercatalog.bookmarked

    signal bookmarksChanged()

    Connections {
         target: catalogProperties
         onBookmarksChanged: { bookmarksChanged()}
     }

    function deleteCurrentBookmark(){
        var index = currentFolders.currentIndex
        mastercatalog.deleteBookmark(index);
        bookmarkModel = mastercatalog.bookmarked

    }

    opacity : 1
    height : defaultHeight
    color : "#C6C6C6"
    clip : true
    state : "visible"
    signal catalogChanged
    radius : 15

    Text {
        id : title
        x : 10
        y : 5
        font.bold : true

        text : "Bookmarked Catalogs"
    }


    Rectangle {

        id : listRect
        anchors.top : title.bottom
        anchors.bottom: catalogProperties.top
        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.topMargin: 5
        x : 5
        width: parent.width - 10
        color : "white"

        radius: 15

        ListView{
            id : currentFolders
            model : bookmarkModel
            width : parent.width - 10
            height : parent.height -5
            x : 5
            y : 5
            clip : true

            signal catalogChanged()

            delegate : Item {
                id : catalogentry
                 height : 40
                width : parent.width - 5
                Rectangle {
                    anchors.fill: parent
                    color: currentFolders.currentIndex == index ? "#00BFFF" : index  % 2 == 0 ? listbackground : listalternate
                    opacity : currentFolders.currentIndex == index ? 0.2 : 1
                    radius : 5
                }
                focus : true

                Column {
                    width : parent.width - 30
                    Text{
                        id : txtlabel
                        text : displayName
                        maximumLineCount: 1
                        y : 3
                        x : 3
                        font.pointSize: 11
                        elide : Text.ElideMiddle
                        width : parent.width
                        height : 20
                        font.family: "Tahoma"
                    }
                    Text {
                        id : pathLable
                        text : url
                        y : 3
                        x : 3
                        font.pointSize: 8
                        elide : Text.ElideMiddle
                        width : parent.width
                        height : 15
                        font.family: "Tahoma"
                        color : "grey"
                    }
                }

                MouseArea {
                    hoverEnabled: true
                    anchors.fill: parent
                    cursorShape: Qt.ArrowCursor
                    onClicked: {
                        currentFolders.currentIndex = index;
                        catalogProperties.humannametext = displayName
                        catalogProperties.defintiontext = url
                        catalogProperties.descriptiontext = description
                        mastercatalog.selectedBookmark = index
                        catalogChanged()

                    }


                }
            }
        }

    }
    Panel.CatalogProperties{
        id : catalogProperties
        anchors.bottom : parent.bottom
        //anchors.top : listRect.bottom
        height : 200
        clip : true
    }

    states: [
        State { name: "visible"

            PropertyChanges {
                target: navigationFoldercreate
                z : 0
                opacity : 1
            }
        },
        State {
            name : "invisible"
            PropertyChanges {
                target: navigationFoldercreate
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
