import QtQuick 2.3
import "../utils" as Utils

Utils.TabBarController {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: __theme.dp(100)

    tabBarModel: [
        {
            icon : "../img/icon-browse.png",
            sourceComponent: _Browse
        },
        {
            icon : "../img/icon-browse.png",
            sourceComponent: _Recent
        },
        {
            icon : "../img/icon-location.png",
            sourceComponent: _Nearby
        }
    ]

    theme.backgroundActiveColor: __theme.vgColorGreen
    theme.backgroundPressedColor: __theme.vgColorGreen
    theme.borderColor: __theme.lightGreyDarker
    theme.iconPressedColor: theme.iconActiveColor

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 2
        color: "#d1d1d0"
        z: 2
    }
}
