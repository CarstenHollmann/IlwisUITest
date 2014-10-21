import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Dialogs 1.0
import "../views" as Views
import "../panel" as Panel
import MasterCatalogModel 1.0
import OperationCatalogModel 1.0
import OperationModel 1.0

Rectangle {
    anchors.fill: parent
    ListView {
        anchors.fill: parent
        model : operations.resources
        delegate : Item{
            Text : { height : 20; width : parent.width; text : displayName}
        }
    }
}
