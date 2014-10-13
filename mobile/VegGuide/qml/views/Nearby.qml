import QtQuick 2.3
import "../utils" as Utils

Utils.BaseTabBarPage {
    id: root

    loadAsNeeded: true

    contentComponent: Component {
        Item {
            // Model
            Connections {
                target: model
                onEntriesChanged: {
                    _EntriesListView.model = model.entries
                }
            }
            Component.onCompleted: {
                model.reload()
            }

            // UI
            Header {
                id: _Header
                attachTo: _EntriesListView
                blurOffset: 0
                Label {
                    anchors.centerIn: parent
                    text: [qsTr("Nearby"), _Location.cityName].filter(Boolean).join(" ")
                }
                z: 3
            }

            EntriesListView {
                id: _EntriesListView
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                z: 2
            }

        }
    }
}
