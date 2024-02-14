import QtQuick 
import QtQuick.Window 
import QtQuick.Layouts 
import QtCore

Window 
{
    id: applicationWindow
    title: "PasswdAdmin"
    visible: true

   Settings
   {
      property alias x: applicationWindow.x
      property alias y: applicationWindow.y
      property alias width: applicationWindow.width
      property alias height: applicationWindow.height
   }

    RowLayout 
    {
        anchors.fill: parent
        spacing: 0

        UserList
        {
            id: userList

            Layout.fillHeight: true
            Layout.fillWidth: true

            onNameSelected: userEdit.nameSelected(name)
        }

        Rectangle
        {
            width: 1
            Layout.fillHeight: true

            color: "#000000"
        }

        UserEdit
        {
            id: userEdit

            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}