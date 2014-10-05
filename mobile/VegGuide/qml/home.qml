import QtQuick 2.3
import "utils" as Utils
import "views" as Views
import QtGraphicalEffects 1.0 as QGE

Rectangle {
    id: root
    color: "#ffffff"

    property alias log : _Log
    Utils.Log { id: _Log }

    property alias theme : _Theme
    Utils.Theme { id: _Theme }

    property alias config : _Config
    Utils.Config { id: _Config }

    property alias model : _Model
    Utils.Model {
        id: _Model
        onEntriesChanged: {
            log.jsonDump(root, entries)
            _ListView.model = entries
        }
    }

    Views.Header {
        id: _Header
        attachTo: _ListView

        Views.Label {
            text: "VegGuide"
            anchors.centerIn: parent
        }
        z: 3
    }

    ListView {
        id: _ListView
        anchors.top: _Header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        displayMarginEnd: 30
        z: 2
        delegate: Rectangle {
            height: 200
            width: ListView.view.width
            color: index%2===0 ? "#f7f7f7" : "#ffffff"
            layer.enabled: true
            layer.smooth: true
            Row {
                anchors.fill: parent
                anchors.leftMargin: 50
                anchors.rightMargin: 50
                anchors.topMargin: 30
                anchors.bottomMargin: 30
                Item {
                    width: 160
                    height: 160
                    anchors.verticalCenter: parent.verticalCenter
                    Image {
                        id: _Image_Thumbnail
                        anchors.fill: parent
                        anchors.margins: 1 // border
                        source: (modelData.images && modelData.images.length > 0 && modelData.images[0].files[1].uri) || ""
                        fillMode: Image.PreserveAspectCrop
                        visible: false
                        Image {
                            anchors.centerIn: parent
                            width: 80
                            visible: parent.status === Image.Null
                                     || parent.status === Image.Loading
                            source: "img/icon-store.png"
                            fillMode: Image.PreserveAspectFit
                            opacity: 0.3
                        }
                    }
                    Image {
                        id: _Rectangle_CircularMask
                        anchors.fill: parent
                        source: "img/squircle.png"
                        fillMode: Image.PreserveAspectFit
                        visible: false
                    }
                    QGE.OpacityMask {
                        id: _OpacityMask
                        anchors.fill: _Image_Thumbnail
                        source: _Image_Thumbnail
                        maskSource: _Rectangle_CircularMask
                    }
                }
                Utils.HorizontalSpacer { width: 20 }
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    Views.Label {
                        width: 400
                        wrapMode: Text.WordWrap
                        text: modelData.name
                        lineHeight: 0.90
                        Utils.Fill { color: "blue" }
                    }
                    Utils.VerticalSpacer { height: 10 }
                    Views.Label {
                        text: [modelData.distance.toFixed(2), "miles"].join(" ")
                        font.pixelSize: 26
                        Utils.Fill { color: "blue" }
                    }
                }
            }
            Utils.AccentTop { color: theme.lightGrey }
            Utils.AccentBottom { color: theme.lightGreyAccentSecondary }
        }
    }
}
