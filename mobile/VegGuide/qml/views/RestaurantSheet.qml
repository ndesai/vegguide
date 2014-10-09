import QtQuick 2.3
import "../utils" as Utils
import QtGraphicalEffects 1.0 as QGE
Slide {
    id: root
    sourceComponent: Item {
        id: _Item

        // UI
        Header {
            id: _Header
            attachTo: _Flickable
            enableLeftAndRightContainers: true
            Label {
                id: _Label_Header_AppName
                anchors.centerIn: parent
                text: config.identifier
            }
            Label {
                id: _Label_Header_Name
                opacity: 0.0
                anchors.centerIn: parent
                text: getProperty("name")
            }
            leftContent: [
                Utils.BaseIcon {
                    id: _BaseIcon_Back
                    anchors.centerIn: parent
                    width: 54
                    source: "../img/icon-arrow-left.png"
                    Utils.ClickGuard {
                        onClicked: root.close();
                    }
                }
            ]
            z: 3

            states: [
                State {
                    name: "scrolledPastTitle"
                    when: _Flickable.contentY > _Flickable.titleEndPosition
                    PropertyChanges {
                        target: _Label_Header_Name
                        opacity: 1.0
                    }
                    PropertyChanges {
                        target: _Label_Header_AppName
                        opacity: 0.0
                    }
                }
            ]

            transitions: [
                Transition {
                    ParallelAnimation {
                        NumberAnimation {
                            target: _Label_Header_AppName; property: "opacity";
                            duration: 350; easing.type: Easing.OutBack
                        }
                        NumberAnimation {
                            target: _Label_Header_Name; property: "opacity";
                            duration: 350; easing.type: Easing.OutBack
                        }
                    }
                }
            ]
        }


        Rectangle {
            id: _Rectangle_ImageContainer
            anchors.top: _Header.bottom
            anchors.topMargin: -1*Math.max(0, _Flickable.contentY)
            width: parent.width
            height: 320
            color: "#f4f4f4"
            opacity: 0
            Behavior on opacity { NumberAnimation{ duration: 1000; } }
            Utils.AsyncImage {
                id: _Image
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                source: getProperty("images")[0].files[3].uri
                onStatusChanged: {
                    if(status === Image.Ready)
                        parent.opacity = 1
                }
            }
            QGE.FastBlur {
                id: _FastBlur_Image
                anchors.fill: parent
                opacity: Math.min(1, Math.max(0.08, (_Flickable.contentY / (-1*height))))
                source: ShaderEffectSource {
                    sourceItem: _Image
                    live: true
                    hideSource: true
                }
                //radius: Math.min(Math.max(0, 128 + _Flickable.contentY), 128)
            }
        }

        Flickable {
            id: _Flickable
            property int titleEndPosition : 200
            property int standardLeftRightMargin : 40
            anchors.top: _Header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            contentWidth: width
            contentHeight: _Column.height

            Column {
                id: _Column
                width: parent.width
                height: childrenRect.height

                Column {
                    width: parent.width
                    height: _Rectangle_ImageContainer.height
                    Utils.VerticalSpacer { height: __theme.dp(40) }
                    Item {
                        anchors.left: parent.left
                        anchors.leftMargin: _Flickable.standardLeftRightMargin
                        anchors.right: parent.right
                        anchors.rightMargin: anchors.leftMargin
                        height: _Label_VegLevel.height
                        Label {
                            id: _Label_VegLevel
                            anchors.left: parent.left
                            font.pixelSize: __theme.dp(28)
                            font.bold: true
                            wrapMode: Text.WordWrap
                            style: Text.Raised
                            styleColor: __theme.lightGreyDarker
                            color: __theme.vgColorDarkGreen
                            font.capitalization: Font.AllUppercase
                            text: getProperty("veg_level_description")
                            Utils.Fill { color: "green" }
                        }
                        DistanceLabel {
                            width: 150
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            text: getProperty("distance") ? [getProperty("distance").toFixed(2), "miles"].join(" ") : ""
                        }
                    }
                    Utils.VerticalSpacer { height: __theme.dp(8) }
                    Label {
                        id: _Label_Title
                        anchors.left: parent.left
                        anchors.leftMargin: _Flickable.standardLeftRightMargin
                        anchors.right: parent.right
                        anchors.rightMargin: anchors.leftMargin
                        font.pixelSize: __theme.dp(48)
                        wrapMode: Text.WordWrap
                        style: Text.Raised
                        styleColor: "#ffffff"
                        text: getProperty("name")
                        Utils.Fill { color: "green" }
                    }
                    Row {
                        id: _Row_VegLevel
                        anchors.left: parent.left
                        anchors.leftMargin: _Flickable.standardLeftRightMargin
                        anchors.right: parent.right
                        anchors.rightMargin: anchors.leftMargin
                        height: __theme.dp(60)
                        property int rating : Math.round(parseFloat(getProperty("weighted_rating")))
                        Repeater {
                            model: 5
                            delegate: Item {
                                width: __theme.dp(40)
                                height: _BaseIcon.height
                                Utils.BaseIcon {
                                    id: _BaseIcon
                                    anchors.centerIn: parent
                                    width: __theme.dp(60)
                                    color: __theme.vgColorDarkGreen
                                    source: "../img/icon-heart.png"
                                    opacity: index < _Row_VegLevel.rating ? 1.0 : 0.5
                                    Utils.Fill { color: "red" }
                                }
                            }
                        }
                        visible: getProperty("weighted_rating")
                    }
                    Utils.VerticalSpacer { height: __theme.dp(6) }
                    Label {
                        id: _Label_Categories
                        anchors.left: parent.left
                        anchors.leftMargin: _Flickable.standardLeftRightMargin
                        anchors.right: parent.right
                        anchors.rightMargin: anchors.leftMargin
                        font.pixelSize: __theme.dp(28)
                        wrapMode: Text.WordWrap
                        style: Text.Raised
                        styleColor: "#ffffff"
                        text: getProperty("categories").concat(getProperty("cuisines")).join(", ")
                        Utils.Fill { color: "green" }
                    }
                }
                Utils.VerticalSpacer { height: 40 }
                Label {
                    id: _Label_Description
                    anchors.left: parent.left
                    anchors.leftMargin: _Flickable.standardLeftRightMargin
                    anchors.right: parent.right
                    anchors.rightMargin: anchors.leftMargin
                    wrapMode: Text.WordWrap
                    font.pixelSize: 28
                    text: getProperty("long_description")["text/vnd.vegguide.org-wikitext"] || getProperty("short_description")
                }
                Rectangle {
                    width: 10
                    height: 5000
                }
            }
        }
    }
}
