import QtQuick 2.1

Item{
    property string title: "Dummy"

    Item{
        ListModel {
            id : dummies

            ListElement {
                label: "dummy item 1"
                number: "101"
            }
            ListElement {
                label: "dummy item 2"
                number: "102"
            }
            ListElement {
                label: "dummy item 3"
                number: "103"
            }
            ListElement {
                label: "dummy item 4"
                number: "104"
            }
            ListElement {
                label: "dummy item 5"
                number: "105"
            }
            ListElement {
                label: "dummy item 6"
                number: "106"
            }
        }
    }

    ListView {

        width: 180; height: 200

        model: dummies
        delegate: Text {
            text: label + ": " + number
        }
    }



}
