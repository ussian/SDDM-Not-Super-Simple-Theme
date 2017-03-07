import QtQuick 2.0

MyComboBox {
    color: "#717171"
    nonHighlightingColor: "#515151"
    textColor: "#e0e000"
    focusColor: "#e0e000"
    hoverColor: "#e0e000"
    borderColor: "#a3a300"
    id: combo

    model: keyboard.layouts
    index: keyboard.currentLayout

    onValueChanged: keyboard.currentLayout = id

    Connections {
        target: keyboard

        onCurrentLayoutChanged: combo.index = keyboard.currentLayout
    }

    rowDelegate: Rectangle {
        color: "transparent"

        Image {
            id: img
            source: "/usr/share/sddm/flags/%1.png".arg(modelItem ? modelItem.modelData.shortName : "zz")

            anchors.margins: 4
            fillMode: Image.PreserveAspectFit

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }

        Text {
            anchors.margins: 4
            anchors.left: img.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: combo.textColor

            verticalAlignment: Text.AlignVCenter

            text: modelItem ? modelItem.modelData.shortName : "zz"
            font.pixelSize: 14
        }
    }
}

