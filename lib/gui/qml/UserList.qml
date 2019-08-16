import QtQuick 2.11
import QtQuick.Layouts 1.11

ListView
{
    id: userList
    signal nameSelected(string name)

    Component
    {
        id: userDelegate

        Item
        {
            width: userList.width
            height: 40

            RowLayout
            {
                anchors.fill: parent

                Text
                {
                    text: name
                }
            }                
        }
    }

    model: userModel
    delegate: userDelegate

    highlight:  Rectangle { color: "#eeeeee" }
    highlightMoveDuration: 1
    highlightFollowsCurrentItem: true

    focus: true
    clip: true   

    MouseArea
    {
        anchors.fill: parent
        propagateComposedEvents: true
        scrollGestureEnabled: true

        onClicked:
        {
            var index = indexAt(mouse.x, mouse.y + contentY)
            currentIndex = index

            var name = userModel.getName(currentIndex)
            nameSelected(name)
        }
    }    

    Component.onCompleted: 
    {
        var name = userModel.getName(currentIndex)
        nameSelected(name)
    }
}