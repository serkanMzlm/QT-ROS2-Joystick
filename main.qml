import QtQuick 2.15
import QtQuick.Window 2.15

Window {

    maximumHeight: 300
    maximumWidth:  600
    minimumHeight: maximumHeight
    minimumWidth:  maximumWidth
    visible: true
    title:   qsTr("joystick")

    property int value_x: 10
    property int value_y: 10
    property bool value : false

    Rectangle{
        id: udrl
        x: 50
        y: 150
        width: 132
        height: 112

        Image {
            id: upper
            x:  50
            y:  0
            source: "/images/up.png"
            MouseArea{
                anchors.fill: parent
                onPressed:{
                    upper.opacity = 0.5
                    _rosNode.buttonCallback(0)
                }
                onReleased: upper.opacity  = 1.0
            }
        }

        Image {
            id: down
            x: 50
            y: 80
            source: "/images/down.png"
            MouseArea{
                anchors.fill: parent
                onPressed:{
                    down.opacity  = 0.5
                    _rosNode.buttonCallback(1)
                }
                onReleased: down.opacity  = 1.0
            }
        }

        Image {
            id: left
            x:  0
            y:  40
            source: "/images/left.png"
            MouseArea{
                anchors.fill: parent
                onPressed:  {
                    left.opacity = 0.5
                    _rosNode.buttonCallback(2)
                }
                onReleased: left.opacity = 1.0
            }
        }

        Image {
            id: right
            x:  100
            y:  40
            opacity: 1.0
            source: "/images/right.png"
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    right.opacity  = 0.5
                    _rosNode.buttonCallback(3)
                }
                onReleased: right.opacity  = 1.0
            }
        }
    }

    Rectangle{
        id: xrtc
        x: 420
        y: 150

        width:  132
        height: 112

        Image {
            id: x_icon
            x:  50
            y:  80
            source: "/images/x.png"
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    x_icon.scale  = 1.3
                    _rosNode.buttonCallback(6)
                }
                onReleased: x_icon.scale = 1.0
            }
        }

        Image {
            id: rec_icon
            x:  0
            y:  40
            source: "/images/rectangle.png"
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    rec_icon.scale  = 1.3
                    _rosNode.buttonCallback(5)
                }
                onReleased: rec_icon.scale = 1.0
            }
        }
        Image {
            id: tri_icon
            x:50
            y:0
            source: "/images/triangle.png"
            MouseArea{
                anchors.fill: parent
                onPressed:   {
                    tri_icon.scale = 1.3
                    _rosNode.buttonCallback(7)
                }
                onReleased: tri_icon.scale = 1.0
            }

        }
        Image {
            id: cir_icon
            x:100
            y:40
            opacity: 1.0
            source: "/images/circle.png"
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    cir_icon.scale  = 1.3
                    _rosNode.buttonCallback(4)
                }
                onReleased: cir_icon.scale = 1.0
            }
        }
    }


    Image {
        id: rec
        x:  268
        y:  166
        opacity: 1.0
        source: "/images/recycle.png"
        MouseArea{
            anchors.fill: rec
            onPressed:{
                rect.x    = value_x
                rect.y    = value_y
                rec.scale = 1.3
                if(value) {
                    rec.source =  "/images/recycle.png"
                    value = false
                    udrl.x = 50
                    udrl.y = 150
                    xrtc.x = 420
                    xrtc.y = 150
                    _rosNode.buttonCallback(8)
                } else {
                    rec.source = "/images/recycle2.png"
                    value = true
                    udrl.x = 420
                    udrl.y = 150
                    xrtc.x = 50
                    xrtc.y = 150
                    _rosNode.buttonCallback(9)
                }
            }
            onReleased: rec.scale = 1.0
        }
    }

    Rectangle {
        id: mainrec
        x:30 ; y:30
        width:  540
        height: 100
        color: "#D9D9D9"
         radius: 20
        clip: true
        Rectangle {
            id: rect
            x: value_x ; y: value_y
            width: 25
            height: 25
            color: "#59BDB7"
            radius: width*0.5
        }

        MouseArea {
           anchors.fill: parent
           onPositionChanged:
           {
               rect.x = mouseX - rect.width / 2;
               rect.y = mouseY - rect.height / 2
               _rosNode.ballStateCallback(rect.x, rect.y)
           }
        }
    }

    Text{
        id: name
        x:275; y:0
        text: _rosNode.name
        font.family: "Arial"
        font.bold: true
        font.pointSize: 14
    }
}
