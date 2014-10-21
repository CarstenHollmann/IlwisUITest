import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0

import "panel" as Panel

Rectangle {
    id : container

    property int defaultWidth: defaultFunctionBarWidth
    property color background1 : "#EAECEE"
    property color background3 : "#E3E3E3"

    signal unloadcontent(string content)
    signal catalogChanged()
    signal showForm(string name, int fwidth, int fheight)

    color : background3
    clip : true
    width : defaultWidth
    state : "visible"
    opacity : 0

    function refreshBookmarks() {
        navCreatePanel.bookmarkModel = mastercatalog.bookmarked
    }

    Connections {
         target: navCreatePanel
         onCatalogChanged: { catalogChanged()}
     }

    Connections {
         target: createCatalogForm
         onBookmarkadded: { refreshBookmarks()}
     }

    Connections {
         target: navCreatePanel
         onBookmarksChanged: { refreshBookmarks()}
     }



    Panel.FunctionBarHeader{
        id : functionBarHeader
        headerImage: "../images/navigatorCS3.png"
        headerText:"Navigator"
    }

    Action {
        id : createCatalog
        onTriggered : {
            createCatalogForm.state = "maximized"
            createCatalogForm.opacity = 1
        }
    }

    Action {
        id : deleteBookmark
        onTriggered : {
            navCreatePanel.deleteCurrentBookmark()
        }
    }

    Rectangle {
        id : buttonBar
        height : 46
        anchors.top : functionBarHeader.bottom
        anchors.topMargin: 3
        width : functionBarHeader.width
        x : functionBarHeader.x
        color : background3
       // border.width: 1

        Row {
            anchors.top : parent.top
            anchors.margins: 3
            Button{
                id : addContainer
                width : 90
                height : 45
                Image { anchors.horizontalCenter: parent.horizontalCenter ;source: "images/catalogsources.png"; y : 5 ;width : 20; height : 20 }
                text :  "\nCatalog Sources"
                action : createCatalog

            }
            Button{
                id : removeBookmark
                width : 90
                height : 45
                Image { anchors.horizontalCenter: parent.horizontalCenter ;source: "images/deletebookmark20.png"; y : 5 ;width : 20; height : 20 }
                text :  "\nDelete Bookmark"
                action : deleteBookmark

            }
       }
    }
    Panel.CreateCatalogForm{
        id : createCatalogForm
        width : parent.width - 10
        height : 0
        anchors.top: buttonBar.bottom
        anchors.margins: 5
        x : parent.x + 5
    }

    Panel.FolderSource{
        id : navCreatePanel
        width : parent.width - 10
        x : parent.x + 5
        defaultHeight: parent.height - buttonBar.height - functionBarHeader.height - createCatalogForm.height - 15
        anchors.top: createCatalogForm.bottom
        anchors.margins: 2
        opacity : 1
        background: container.background1
        listbackground: "#FFFEF8"
        listalternate: "#FFFEF8"

    }



    states: [
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
              NumberAnimation {
                  properties: "opacity"; duration : 500 ; easing.type: Easing.Linear
              }
              onRunningChanged :
              {
                  if ( opacity == 0) {
                    unloadcontent("Navigator.qml")
                  }
              }

          }
      ]


}
