import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick 2.0

Item {
    height : 22
    width : 100

    function fromRange(rangedef){
        var index = rangedef.indexOf(":")
        var items = rangedef.substring(index + 1).split("|")
        return items;

    }

    ComboBox {
        height : 22
        width : 100
        model : fromRange(rangeDefinition)
    }
}
