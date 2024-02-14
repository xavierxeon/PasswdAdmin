import QtQuick 
import QtQuick.Layouts 

FocusScope 
{
    property alias label: label.text
    property alias input: input.text
    property bool stealth: false
    property bool error: false
    signal inputHasChanged()

    height: 40

    Text
    {
        id: label

        anchors.left: parent.left

        horizontalAlignment: Text.AlignRight
        width: 160
        rightPadding: 20

        font.bold: true        
        color: error ? "#aa0000" : "#000000"
    }


    TextInput
    {
        id: input
        anchors.left: label.right
        anchors.right: parent.right     

        focus: true

        font.bold: true
        echoMode: stealth ? TextInput.Password : TextInput.Normal 
        color: error ? "#aa0000" : "#000000"

        onTextEdited: inputHasChanged()
    }
    Rectangle
    {
        anchors.left: input.left
        anchors.right: input.right   
        anchors.bottom: input.bottom  

        height: 2

        border.width: 1
        border.color: error ? "#bbaaaa" : "#aaaaaa"
    }
}