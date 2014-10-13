import QtQuick 2.0
import "../utils" as Utils
Row {
    property alias text : _Label_Distance.text
    width: parent.width
    height: _Label_Distance.height
    visible: _Label_Distance.text !== ""
    Utils.BaseIcon {
        id: _BaseIcon_LocationArrow
        width: __theme.dp(20)
        anchors.verticalCenter: parent.verticalCenter
        source: "../img/icon-locationarrow.png"
        color: _Label_Distance.color
    }
    Utils.HorizontalSpacer { id: _HS_Distance; width: __theme.dp(10) }
    Label {
        id: _Label_Distance
        width: parent.width - _BaseIcon_LocationArrow.width - _HS_Distance
        font.pixelSize: __theme.dp(26)
        color: __theme.vgColorBeetPurple
        Utils.Fill { color: "blue" }
    }
}
