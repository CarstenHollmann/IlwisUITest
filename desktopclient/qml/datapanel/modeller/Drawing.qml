import QtQuick 2.0

Canvas {
    id:canvas
    property int paintX
    property int paintY
    property int count: 0
    property int lineWidth: 5
    property string drawColor: "black"
    property var ctx: canvas.getContext("2d");
    MouseArea {
        id:mousearea
        hoverEnabled:true
        anchors.fill: parent
        onClicked: drawPoint();
        onPressed: drawPoint();
        onPositionChanged: {
            if (mousearea.pressed)
                drawLineSegment();
            paintX = mouseX;
            paintY = mouseY;
        }
        onReleased: drawPoint();
    }
    function drawLineSegment() {
        ctx.beginPath();
        ctx.strokeStyle = drawColor
        ctx.lineWidth = lineWidth
        ctx.moveTo(paintX, paintY);
        ctx.lineTo(mousearea.mouseX, mousearea.mouseY);
        ctx.stroke();
        ctx.closePath();
    }
    function drawPoint() {
        ctx.lineWidth = lineWidth
        ctx.fillStyle = drawColor
        ctx.fillRect(mousearea.mouseX-10, mousearea.mouseY-10, 20, 20);
    }
    function clear() {
        console.log("clearFunc");
        ctx.reset();
        ctx.clearRect(0, 0, width, height);
    }

    function zoomIn() {
        console.log("zoomInFunc");
        ctx.scale(1.5, 1.5);
    }

    function zoomOut() {
        console.log("zoomOutFunc");
        ctx.scale(0.5, 0.5);
    }

}
