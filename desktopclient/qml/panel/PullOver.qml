import QtQuick 2.1

Rectangle{
    id : pullover
    property int barsize : parent.height
    property int tagheight : height / pane.children.length
    property int tagwidth : 28
    property int maxPull : 300
    property color tagcolor : "#DDDDDD"
    property color backcolortop : "#FFFFFF"
    property color backcolorbottom : "#EEEEEE"
    default property alias content  :pane.children
    property int current: 0
    property int pullWidth : 0
    property string orientation : "left"
    property int maxWidth : parent.parent.width

    onCurrentChanged: setSelection()
    Component.onCompleted: setSelection()

    function setSelection() {
        for (var i = 0; i < pane.children.length; ++i) {
            pane.children[i].opacity = (i == current ? 1 : 0)
        }
    }

   anchors.top: parent.top;
   height: parent.height
   //width : 300

    Rectangle {
        id: pane
        height : parent.height
        anchors.left : parent.left
        anchors.right : headers.left

        smooth:true
        clip : true
        border.width: 1
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: backcolortop;
            }
            GradientStop {
                position: 1.00;
                color: backcolorbottom;
            }
        }
    }
    Column{
        id : headers
        width : tagwidth
        height : parent.height
        x : 0
        Repeater {
            model : pane.children.length
            delegate:
                Rectangle{
                width: tagwidth
                height : tagheight
                color : "#EEEEEE"
                  BorderImage {
                    width: tagwidth
                    height : tagheight
                    source : pullover.current != index ? "../images/label3.png" : "../images/label4.png"
                    smooth : true
                    opacity:  pullover.current == index ? 1 : 0.7


                    Image {
                        x: 2
                        y :2
                        width : 10
                        height : 10
                        source :  "../images/min1.png"
                        opacity: index == 0 ? 0.4 : 0
                    }

                    Image {
                        x: 14
                        y :2
                        width : 10
                        height : 10
                        source :  "../images/max1.png"
                        opacity: index == 0 ? 0.4 : 0
                    }

                    Image {
                        x: 2
                        y : index == 0 ? 20 : 5
                        width : 21
                        height : 21
                        source :  "../images/rasterCS.png"  //pane.children[index].image
                        smooth:true
                    }

                    Text{
                        x :0
                        y :0
                        anchors.leftMargin: paintedHeight
                        text: pane.children[index].title
                        elide: Text.ElideRight
                        font.bold: pullover.current == index
                        transform: [
                            Rotation{ origin.x:0; origin.y:24;angle:90},
                            Translate{ y : pane.children[index].title === "" ? 0 : (index == 0 ? 20 : 10) },
                            Translate{ x : pane.children[index].title === "" ? 0 : -5}
                        ]

                        color:  "black"
                         font.family: "Verdana"
                        font.pointSize: 10
                        smooth: true
                    }


                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        drag.target: headers
                        drag.axis: Drag.XAxis;
                        drag.minimumY: 0
                        drag.maximumY: pane.height
                        drag.minimumX: 0
                        drag.maximumX: maxPull
                        onClicked: pullover.current = index
                    }
                }
            }
        }
        onXChanged: {
            pullWidth = pane.width + 32;

        }
    }


}




