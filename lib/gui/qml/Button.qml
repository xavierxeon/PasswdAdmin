
import QtQuick 

Rectangle
{
    signal clicked()
    property alias text: label.text
    property bool enabled: true

    height: 30

    border.width: 1
    border.color: enabled ? "#00000" : "#aaaaaa"

    Text
    {
        id: label
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.bold: true
        font.pointSize: 15

        color: parent.enabled ? "#00000" : "#aaaaaa"
    }

    MouseArea
    {
        anchors.fill: parent
        propagateComposedEvents: true
        scrollGestureEnabled: true

        onClicked: 
        {
            if(parent.enabled) 
                parent.clicked()
        }
    } 
}