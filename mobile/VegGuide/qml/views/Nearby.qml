import QtQuick 2.3
import "../utils" as Utils
import QtGraphicalEffects 1.0 as QGE

Utils.BaseTabBarPage {
    id: root

    loadAsNeeded: true

    contentComponent: Component {
        Item {
            // Model
            Connections {
                target: model
                onEntriesChanged: {
                    _ListView.model = model.entries
                }
            }
            Component.onCompleted: {
                model.reload()
            }

            // UI
            Header {
                id: _Header
                attachTo: _ListView
                blurOffset: 0
                Label {
                    text: qsTr("Nearby")
                    anchors.centerIn: parent
                }
                z: 3
            }

            ListView {
                id: _ListView
                //        anchors.top: _Header.bottom
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                displayMarginEnd: __theme.dp(30)
                z: 2

                // displayMarginBeginning does not work properly
                header: Item {
                    width: 1
                    height: _Header.height
                }

                delegate: Rectangle {
                    height: __theme.dp(200)
                    width: ListView.view.width
                    color: index%2===0 ? "#f7f7f7" : "#ffffff"
                    Utils.ClickGuard {
                        onClicked: {
                            log.notice(root, "clicked")
                        }
                    }
                    Utils.Fill { anchors.fill: _Row; color: "yellow" }
                    Row {
                        id: _Row
                        anchors.fill: parent
                        anchors.leftMargin: __theme.dp(40)
                        anchors.rightMargin: __theme.dp(40)
                        anchors.topMargin: __theme.dp(30)
                        anchors.bottomMargin: __theme.dp(30)
                        layer.enabled: true
                        layer.smooth: true
                        Item {
                            width: __theme.dp(160)
                            height: __theme.dp(160)
                            anchors.verticalCenter: parent.verticalCenter
                            Item {
                                id: _Item_Thumbnail
                                anchors.fill: parent
                                visible: false
                                Rectangle {
                                    id: _Rectangle
                                    anchors.fill: _Image_Thumbnail
                                    color: __theme.vgColorLightGreen
                                    Utils.BaseIcon {
                                        anchors.centerIn: parent
                                        width: __theme.dp(80)
                                        source: "../img/icon-store.png"
                                        color: "#ffffff"
                                    }
                                }
                                Utils.AsyncImage {
                                    id: _Image_Thumbnail
                                    anchors.fill: parent
                                    anchors.margins: __theme.dp(1) // border
                                    source: (modelData.images && modelData.images.length > 0 && modelData.images[0].files[1].uri) || ""
                                    fillMode: Image.PreserveAspectCrop
                                    cache: true
                                }
                            }

                            Image {
                                id: _Rectangle_CircularMask
                                anchors.fill: parent
                                source: "../img/squircle.png"
                                fillMode: Image.PreserveAspectFit
                                visible: false
                            }

                            QGE.OpacityMask {
                                id: _OpacityMask
                                anchors.fill: _Item_Thumbnail
                                source: _Item_Thumbnail
                                maskSource: _Rectangle_CircularMask
                            }
                        }
                        Utils.HorizontalSpacer { width: __theme.dp(20) }
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: __theme.dp(480)
                            Label {
                                width: parent.width
                                wrapMode: Text.WordWrap
                                lineHeight: 0.90
                                text: modelData.name
                                Utils.Fill { color: "blue" }
                            }
                            Utils.VerticalSpacer { height: __theme.dp(10) }
                            Label {
                                width: parent.width
                                font.pixelSize: __theme.dp(26)
                                elide: Text.ElideRight
                                text: modelData.categories.join(", ")
                                Utils.Fill { color: "blue" }
                            }
                            Utils.VerticalSpacer { height: __theme.dp(10) }
                            Row {
                                width: parent.width
                                height: _Label_Distance.height
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
                                    text: [modelData.distance.toFixed(2), "miles"].join(" ")
                                    color: __theme.vgColorDarkRed
                                    Utils.Fill { color: "blue" }
                                }
                            }
                        }
                    }
                    Utils.AccentTop { color: __theme.lightGrey }
                    Utils.AccentBottom { color: __theme.lightGreyAccentSecondary }
                }
            }
        }
    }
}
