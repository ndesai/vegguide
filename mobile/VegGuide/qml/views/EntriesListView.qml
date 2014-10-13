import QtQuick 2.3
import QtGraphicalEffects 1.0 as QGE
import "../utils" as Utils

ListView {
    id: root
    property bool showLocationDetail : false

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
                log.jsonDump(root, modelData)
                _RestaurantSheet.openWithObject(modelData)
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
                Utils.VerticalSpacer { visible: _DistanceLabel.visible; height: __theme.dp(10) }
                DistanceLabel {
                    id: _DistanceLabel
                    visible: text !== ""
                    text: (modelData.distance
                           && [modelData.distance.toFixed(2), "miles"].join(" "))
                          || ""
                }
                Utils.VerticalSpacer { height: __theme.dp(6) }
                Label {
                    id: _Label_LocationDetail
                    font.pixelSize: __theme.dp(26)
                    visible: root.showLocationDetail && text !== ""
                    text: [modelData.neighborhood || modelData.city || "", modelData.postal_code || ""].filter(Boolean).join(" – ")
                }
            }
        }
        Utils.AccentTop { color: __theme.lightGrey }
        Utils.AccentBottom { color: __theme.lightGreyAccentSecondary }
    }
}
