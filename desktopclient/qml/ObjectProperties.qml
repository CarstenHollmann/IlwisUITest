import QtQuick 2.0
import "panel" as Panel

Rectangle {
    id : propertyFormContainer
    property int defaultWidth: defaultFunctionBarWidth

    signal unloadcontent(string content)

    color : background4
    clip : true
    width : defaultWidth
    state : "visible"
    height : 500
    opacity : 1

    Panel.FunctionBarHeader{
        headerImage: "../images/propertiesCS3.png"
        headerText:"Object properties"
    }








    states: [
        State { name: "visible"

            PropertyChanges {
                target: propertyFormContainer
                opacity : 1
            }
        },
        State {
            name : "invisible"
            PropertyChanges {
                target: propertyFormContainer
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
                    unloadcontent("ObjectProperties.qml")
                }
            }

        }
    ]
}
