import QtQuick 2.11
import QtQuick.Layouts 1.11

Item
{
    id: userEdit

    function checkInput()
    {
        if(passwordFirst.input !== passwordSecond.input)
        {
            passwordSecond.error = true
            applyButton.enabled = false
        }
        else
        {
            passwordSecond.error = false
            if(passwordFirst.input.length > 0)
                applyButton.enabled = true

        }
    }
    Component.onCompleted: checkInput()

    function nameSelected(name)
    {
        userName.input = name
        passwordFirst.input = ""
        passwordSecond.input = ""
    }

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 0

        Item
        {
            height: 10
        }

        InputRow
        {
            id: userName

            Layout.fillWidth: true
            label: "User Name"
            input: "Hello"

            KeyNavigation.tab: passwordFirst
            KeyNavigation.backtab: passwordSecond
        }
        InputRow
        {
            id: passwordFirst

            Layout.fillWidth: true
            label: "Password"
            input: ""
            stealth: true

            onInputHasChanged: checkInput()
            KeyNavigation.tab: passwordSecond
            KeyNavigation.backtab: userName
        }
        InputRow
        {
            id: passwordSecond

            Layout.fillWidth: true
            label: "Password (repeat)"
            input: ""
            stealth: true

            onInputHasChanged: checkInput()
            KeyNavigation.tab: userName
            KeyNavigation.backtab: passwordFirst
        }

        Item
        {
            height: 10
        }

        Button
        {
            id: applyButton

            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20

            text: "APPLY"
            enabled: false

            onClicked: userModel.addUser(userName.input, passwordFirst.input)
        }

        Item
        {
            height: 10
        }

        Button
        {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20

            text: "REMOVE"

            onClicked: userModel.removeUser(userName.input)
        }

        Item
        {
            Layout.fillHeight: true
        }
    }
}