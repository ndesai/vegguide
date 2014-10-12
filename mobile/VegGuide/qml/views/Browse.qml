import QtQuick 2.3
import "../utils" as Utils
import QtGraphicalEffects 1.0 as QGE

Utils.BaseTabBarPage {
    id: root

    loadAsNeeded: true

    contentComponent: Component {
        Item {
            // Model
            Component.onCompleted: {
                model.load(config.apiRegion, function(entries) {
                    // entries.regions.primary
                    // entries.regions.secondary
                    _ListView.model = entries.regions.primary.concat(entries.regions.secondary)
                })
            }

            // UI
            Header {
                id: _Header
                attachTo: _ListView
                blurOffset: 0
                Label {
                    anchors.centerIn: parent
                    text: qsTr("Browse")
                }
                z: 3
            }

            ListView {
                id: _ListView
                anchors.fill: parent
                header: Item {
                    height: _Header.height + __theme.dp(14)
                    width: 1
                }
                footer: Item {
                    height: __theme.dp(20)
                    width: 1
                }
                delegate: Item {
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
                    }
                }
            }
        }
    }
}
