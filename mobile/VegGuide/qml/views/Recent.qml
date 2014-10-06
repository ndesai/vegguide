import QtQuick 2.3
import "../utils" as Utils
import QtQuick.XmlListModel 2.0

Utils.BaseTabBarPage {
    id: root
    XmlListModel {
        id: _XmlListModel
        source: config.apiRecent
        query: "/rss/channel/item"
        property variant ns : [
            "declare namespace blogChannel = 'http://backend.userland.com/blogChannelModule'",
            "declare namespace geo = 'http://www.w3.org/2003/01/geo/wgs84_pos#'",
            "declare namespace dcterms = 'http://purl.org/dc/terms/'",
            "declare namespace content = 'http://purl.org/rss/1.0/modules/content/'",
            ""
        ]
        namespaceDeclarations: ns.join("; ")
        XmlRole {
            name: "title"
            query: "title/string()"
        }
        XmlRole {
            name: "description"
            query: "content:encoded/string()"
        }
        XmlRole {
            name: "date"
            query: "dcterms:modified/string()"
        }
        XmlRole {
            name: "author"
            query: "author/string()"
        }

        onStatusChanged: {
            log.notice(root, "status = " + status)
            log.notice(root, "count="+count)
            log.jsonDump(root, get(0))
        }
    }


    Header {
        id: _Header
        attachTo: _ListView
        blurOffset: 0
        Label {
            text: qsTr("Recent")
            anchors.centerIn: parent
        }
        z: 3
    }

    ListView {
        id: _ListView
        anchors.fill: parent
        model: _XmlListModel

        header: Item {
            width: 1
            height: _Header.height
        }

        delegate: Rectangle {
            id: _Rectangle_Delegate
            height: __theme.dp(320)
            width: ListView.view.width
            color: index%2===0 ? "#f7f7f7" : "#ffffff"
            clip: true

            Utils.ClickGuard {
                onClicked: {
                    log.notice(root, "clicked")
                    log.notice(root, JSON.stringify(_Label_Description.text))
                }
            }

            Utils.AccentBottom {
                color: __theme.lightGreyAccentSecondary
            }

            Utils.AccentTop {
                color: __theme.lightGreyAccent
            }

            Utils.BaseIcon {
                id: _BaseIcon_RightArrow
                width: __theme.dp(40)
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: __theme.dp(20)
                source: "../img/icon-arrow-right.png"
                color: __theme.colorBaseTextLighter
            }

            Column {
//                anchors.top: parent.top
//                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: _BaseIcon_RightArrow.left
                anchors.leftMargin: __theme.dp(40)
//                anchors.topMargin: __theme.dp(30)
//                anchors.bottomMargin: __theme.dp(30)
                anchors.rightMargin: __theme.dp(10)
                height: childrenRect.height
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    width: parent.width
                    font.pixelSize: __theme.dp(22)
                    color: __theme.colorBaseTextLighter
                    text: Qt.formatDate(model.date, "dddd, MMMM d").toUpperCase() + " <i>by " + model.author + "</i>"
                    Utils.Fill { color: "blue" }
                }
                Utils.VerticalSpacer { height: __theme.dp(6) }
                Label {
                    id: _Label_Title
                    width: parent.width
                    wrapMode: Text.WordWrap
                    lineHeight: 0.90
                    color: __theme.vgColorBeetPurple
                    text: model.title
                    maximumLineCount: 3
                    Utils.Fill { color: "green" }
                }
                Utils.VerticalSpacer { height: __theme.dp(12) }
                Label {
                    id: _Label_Description
                    width: parent.width
                    font.pixelSize: __theme.dp(30)
                    color: __theme.colorBaseTextLighter
                    wrapMode: Text.WordWrap
                    maximumLineCount: _Label_Title.lineCount > 2 ? 3 : 4
                    elide: Text.ElideRight
                    text: model.description
                    .replace(/<strong>.*<\/strong>/g, '')
                    .replace(/<[^>]*>/g, ' ')
                    .replace(/\t/g, '')
                    .replace(/&amp;/g, '&')
                    .replace(/((?<=[A-Za-z0-9])\.(?=[A-Za-z]{2})|(?<=[A-Za-z]{2})\.(?=[A-Za-z0-9]))/, '. ')
                    .replace(/\n\s+\n\s+\n/g, '\n')
                    .replace(/\n\s+\n/g, '\n')
                    .replace(/\n\s+/g, '\n')
                    .trim()
                    Utils.Fill { color: "blue" }
                }
            }
        }

        z: 2
    }
}
