import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import Qt.labs.folderlistmodel 2.1
import MasterCatalogModel 1.0

Rectangle {
    height : 0
    width : 0
    opacity: 0
    color : "#C6C6C6"

    property string startfolder: "file:///d:/Data"
    property string currentFolder

    signal bookmarkadded()

    function path2pathView(pathString){
        var index =  pathString.lastIndexOf("/..")
        if ( index !== -1){
            pathString = pathString.slice(0,index) // chop the /..
            index = pathString.lastIndexOf("/")
            if ( index !== -1){
                pathString = pathString.slice(0,index)  // chop the last 'real'folder as that is what we want here
            }
        }

        var parts = pathString.split("/");
        pathModel.clear()
        for (var i = 0; i < parts.length; i++){
            pathModel.append({"folderid" : parts[i] + "/"})
        }

    }

    function parseFilePath(index){
        var scheme = "file:///";
        var path = currentFolder.slice(scheme.length())
        var parts = path.split("/");
        var newPath;
        for(var i=0; i < index; ++i){
            if ( i > 0)
                newPath += "/"
            newPath += parts[i]
        }
        console.debug(newPath)
    }

    Component {
        id : pathViewDelegate
        Text  {
            height : 20
            text :folderid;
            verticalAlignment: Text.AlignVCenter
            Rectangle {
                anchors.fill: parent
                color : "grey"
                opacity : 0.2
            }


        }
    }

    ListModel {
        id: pathModel
    }

    id: catalogTypes
    TabView {
        id : tabs
        y : 5
        height : parent.height - buttonRow.height - 15
        anchors.left: parent.left
        anchors.right : parent.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        clip : true
        Tab {
            id : filetab
            height: parent.height
            width : parent.width
            title : "File"
            Rectangle {
                id : folderlist
                width : parent.width - 3
                height : parent.height - 30
                color : "white"
                radius: 10
                y : 3
                x : 0
                ComboBox {
                    id : drivelist
                    anchors.top :folderlist.top
                    width: parent.width
                    height : 20
                    model: mastercatalog.driveList()
                    Layout.fillWidth: true
                    onCurrentIndexChanged: {
                        var drivePath = mastercatalog.getDrive(currentIndex)
                        startfolder = "file:///"+ drivePath
                        path2pathView(drivePath)
                        folderModel.folder = "file:///"+ drivePath
                    }
                }
                Rectangle {
                    id : pathView
                    width: parent.width
                    height : 20
                    anchors.top : drivelist.bottom
                    anchors.topMargin: 1
                    border.width: 1
                    border.color: "lightgrey"

                    ListView{
                        id : pathListView
                        anchors.fill: parent
                        model: pathModel
                        orientation : ListView.Horizontal
                        delegate: pathViewDelegate
                    }
                }
                Rectangle {
                    anchors.top : pathView.bottom
                    anchors.topMargin: 3
                    width: parent.width;
                    height :parent.height - 5
                    clip : true
                    ListView {
                        id : fileFolders
                        anchors.fill: parent

                        FolderListModel {
                            id: folderModel
                            folder : startfolder
                            showDirs: true
                            showDotAndDotDot: true
                            showFiles: false;
                        }

                        model: folderModel
                        delegate: Item {
                            id: fileDelegate
                            width : fileFolders.width
                            height : 20

                            Rectangle{
                                anchors.fill: parent
                                color :  fileFolders.currentIndex == index ? "lightgrey" : "white"
                                Image{ x : 2;y:3; id : folderico; source : "../images/folder16.png"}
                                Text { id: filename; text: fileName; anchors.left : folderico.right; anchors.leftMargin: 5;anchors.verticalCenter: parent.verticalCenter }
                            }

                            MouseArea{
                                anchors.fill:  parent
                                hoverEnabled: true
                                onClicked: {
                                    //fileFolders.currentIndex = index;
                                    var path = folderModel.get(index,"filePath")
                                    mastercatalog.addCatalog(path);
                                    path2pathView(path)
                                    currentFolder = "file:///"+ path;
                                    folderModel.folder = currentFolder;
                                }

                            }

                        }
                    }
                }
            }
        }
        Tab {

            title : "Service"
            height: parent.height
            width : parent.width
            Item {
                anchors.fill: parent
                anchors.topMargin: 5
                SelectServiceForm{}
            }
        }
        Tab {
            title : "Database"
        }

        Tab {
            title : "Selection"
        }
        style: TabViewStyle {
            frameOverlap: 1
            tab: Rectangle {
                color: styleData.selected ? "steelblue" :"lightsteelblue"
                border.color:  "steelblue"
                implicitWidth: Math.max(text.width + 4, 70)
                implicitHeight: 20
                radius: 2
                Text {
                    id: text
                    anchors.centerIn: parent
                    text: styleData.title
                    color: styleData.selected ? "white" : "black"
                }
            }
            frame: Rectangle { color: "#C6C6C6"; radius : 10 }
        }
    }
    Action {
        id :close
        onTriggered: {
            createCatalogForm.state = "minimized"
        }
    }

    Action {
        id :addbookmark
        onTriggered: {
            mastercatalog.addBookmark(currentFolder)
            bookmarkadded()
        }
    }
    Row {
        id : buttonRow
        height : functionBarHeader.height
        anchors.right : createCatalogForm.right
        anchors.bottom: createCatalogForm.bottom
        anchors.rightMargin: 85
        anchors.bottomMargin: 5
        width : 80
        Button{
            text : "Add Bookmark"
            id : addbutton
            height : 30
            width :80
            action : addbookmark
            z : 1
        }
        Button{
            text : "Close"
            id : closebutton
            height : 30
            width :80
            action : close
            z : 1

        }

    }

    states: [
        State { name: "maximized"

            PropertyChanges {
                target: createCatalogForm
                height : 400
                opacity : 1

            }
        },
        State {
            name : "minimized"
            PropertyChanges {
                target: createCatalogForm
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
