import QtQuick 2.8
import SddmComponents 2.0

Rectangle{

    property bool visibility : false

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    Connections {
        target: sddm
        onLoginSucceeded: {
        }
        onLoginFailed: {
            passBox.text = ""
            errorMessageText.text ="You did something wrong!"
        }
    }

    Background {
        anchors.fill: parent
        source: "background-link"
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }


    Text { //Clock & Date
        id: time_label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 4
        anchors.top: parent.top

        text: Qt.formatDateTime(new Date(), "dddd, dd MMMM yyyy HH:mm AP")

        horizontalAlignment: Text.AlignRight

        color: "#e0e000"
        font.bold: true
        font.pixelSize: 12
    }



MyTextBox{
    id: userBox
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.margins: 4
    radius: 4

    text: userModel.lastUser

    borderWidth: 3

    color: "#717171"
    textColor: "#e0e000"
    focusColor: "#e0e000"
    hoverColor: "#e0e000"
    borderColor: "black"

    KeyNavigation.backtab: settingsWheelImageMouseArea; KeyNavigation.tab: passBox

    Keys.onPressed: {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            sddm.login(userBox.text, passBox.text, sessionManager.index)
            event.accepted = true
        }
    }
}

MyPasswordBox{
    id: passBox
    anchors.left: userBox.right
    anchors.top: parent.top
    anchors.margins: 4
    radius: 4

    state: keyboard.numLock = true

    focus:true

    borderWidthpass: 3

    color: "#717171"
    textColor: "#e0e000"
    focusColor: "#e0e000"
    hoverColor: "#e0e000"
    borderColor: "black"

    KeyNavigation.backtab: userBox; KeyNavigation.tab: rebootButton

    Keys.onPressed: {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            sddm.login(userBox.text, passBox.text, sessionManager.index)
            event.accepted = true
        }
    }
}

Rectangle{
    id: errorMessageRect

    height: 30
    width: 160

    anchors.left: parent.left
    anchors.top: userBox.bottom
    anchors.margins: 5

    color: "transparent"
    Text{id: errorMessageText; text: ""; color:"red"; anchors.fill: parent}
}


Row{ //shutdown and reboot button
    anchors.margins: 4
    spacing: 4
    anchors.right: parent.right
    anchors.top: parent.top

    MyButton {
        id:rebootButton
        radiusReal: 4

        border.width: 3
        color: "#717171"
        textColor: "#e0e000"
        pressedColor: "#666666"
        activeColor: "#717171"
        disabledColor: "red"
        hoverBorderColor: "#e0e000"
        text: "Reboot"
        onClicked: sddm.reboot()

        KeyNavigation.backtab: passBox; KeyNavigation.tab: shutdownButton
    }
    MyButton {
        id:shutdownButton
        radiusReal: 4

        border.width: 3
        color: "#717171"
        textColor: "#e0e000"
        pressedColor: "#666666"
        activeColor: "#717171"
        disabledColor: "red"
        hoverBorderColor: "#e0e000"
        text: "Shutdown"
        onClicked: sddm.powerOff()

        KeyNavigation.backtab: rebootButton; KeyNavigation.tab: settingsWheelImageMouseArea
    }

}


Image {
    id: settingsWheelImage
    source: "settingsImage.png"

    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.margins: 10

    fillMode: Image.PreserveAspectFit
    height: 27

    MouseArea {
        id: settingsWheelImageMouseArea

        anchors.fill:parent

        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (visibility === false) {
                visibility = true
                console.log("open first menu")
            }else{
                visibility = false
                console.log("close first menu")
            }
        }
    }

    MyLayoutBox{
        id: layoutBox
        anchors.bottom: sessionManager.top
        anchors.left: sessionManager.left
        visible: visibility
    }

    MyComboBox{
        id: sessionManager
        visible: visibility
        anchors.left: parent.right
        anchors.bottom: parent.bottom

        color: "#717171"
        nonHighlightingColor: "#515151"
        textColor: "#e0e000"
        focusColor: "#e0e000"
        hoverColor: "#e0e000"
        borderColor: "#a3a300"

        model:sessionModel
        index: sessionModel.lastIndex
    }
}



}
