import QtQuick 2.0
import "../utils" as Utils

ListView {
    id: _ListView

    signal itemClicked(variant dataObject)

    width: root.width
    height: root.height
    header: Item {
        height: _Header.height + __theme.dp(14)
        width: 1
    }
    footer: Item {
        height: __theme.dp(20)
        width: 1
    }

    delegate: Item {
        id: _Item_Delegate
        width: ListView.view.width
        height: __theme.dp(120)
        Utils.Fill { color: index%2==0 ? "blue" : "green" }
        Rectangle {
            anchors.fill: parent
            anchors.leftMargin: __theme.listLeftRightMargins
            anchors.rightMargin: __theme.listLeftRightMargins
            anchors.topMargin: __theme.dp(14)
            anchors.bottomMargin: __theme.dp(14)
            radius: __theme.dp(10)
            color: __theme.lightGrey
            border { width: __theme.dp(1); color: __theme.lightGreyAccent }
            Label {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: _BaseIcon_RightArrow.left
                anchors.margins: __theme.dp(20)
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: __theme.dp(36)
                color: __theme.colorBaseText
                text: modelData.name
                Utils.Fill { color: "red" }
            }
            Utils.BaseIcon {
                id: _BaseIcon_RightArrow
                width: __theme.dp(40)
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: __theme.dp(20)
                source: "../img/icon-arrow-right.png"
                color: __theme.colorBaseTextLighter
                Utils.Fill { color: "yellow" }
            }
            Utils.ClickGuard {
                onClicked: {
                    _Item_Delegate.ListView.view.itemClicked(modelData)
                }
            }
        }
    }
}
