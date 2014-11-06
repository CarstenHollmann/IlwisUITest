import QtQuick 2.2
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Dialogs 1.0

Text {

    function fromRange(rangedef){
        var index = rangedef.indexOf(":")
        var items = rangedef.substring(index + 1)
        return items;

    }
    height: 22
    text : fromRange(rangeDefinition)
    Layout.minimumWidth: 150
}
