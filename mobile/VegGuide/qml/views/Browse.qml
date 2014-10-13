import QtQuick 2.3
import "../utils" as Utils
import QtGraphicalEffects 1.0 as QGE
import QtQuick.Controls 1.2 as Controls

Utils.BaseTabBarPage {
    id: root

    loadAsNeeded: true

    contentComponent: Component {
        Item {
            id: _Item
            // Model
            Component.onCompleted: {
                model.load(config.apiRegion, function(entries) {
                    // entries.regions.primary
                    // entries.regions.secondary
                    _RegionsList.model = entries.regions.primary.concat(entries.regions.secondary)
                })
            }

            // UI
            Header {
                id: _Header
                attachTo: _Row
                blurOffset: 0
                Label {
                    id: _Label_Header
                    anchors.centerIn: parent
                    text: qsTr("Browse")
                }
                enableLeftAndRightContainers: true
                leftContent: [
                    Utils.BaseIcon {
                        id: _BaseIcon_Back
                        anchors.centerIn: parent
                        anchors.horizontalCenterOffset: __theme.dp(10)
                        source: "../img/icon-arrow-left.png"
                        Utils.ClickGuard {
                            onClicked: _StateGroup.previous()
                        }
                        visible: _StateGroup.state !== "1-regions"
                    }
                ]
                z: 3
            }

            StateGroup {
                id: _StateGroup
                property int stateNumber : 1
                states: [
                    State {
                        name: "1-regions"
                        when: _StateGroup.stateNumber===1
                        PropertyChanges {
                            target: _Row
                            x: 0
                        }
                        PropertyChanges {
                            target: _Label_Header
                            text: qsTr("Browse")
                        }
                        PropertyChanges {
                            target: _Header
                            attachTo: _RegionsList
                        }
                    },
                    State {
                        name: "2-countries"
                        when: _StateGroup.stateNumber===2
                        PropertyChanges {
                            target: _Row
                            x: -1*_Item.width
                        }
                        PropertyChanges {
                            target: _Header
                            attachTo: _CountriesList
                        }
                    },
                    State {
                        name: "3-states"
                        when: _StateGroup.stateNumber===3
                        PropertyChanges {
                            target: _Row
                            x: -1*2*_Item.width
                        }
                        PropertyChanges {
                            target: _Header
                            attachTo: _StatesList
                        }
                    },
                    State {
                        name: "4-cities"
                        when: _StateGroup.stateNumber===4
                        PropertyChanges {
                            target: _Row
                            x: -1*3*_Item.width
                        }
                        PropertyChanges {
                            target: _Header
                            attachTo: _CitiesList
                        }
                    },
                    State {
                        name: "5-entries"
                        when: _StateGroup.stateNumber===5
                        PropertyChanges {
                            target: _Row
                            x: -1*4*_Item.width
                        }
                        PropertyChanges {
                            target: _Header
                            attachTo: _EntriesListView
                        }
                    }
                ]
                transitions: [
                    Transition {
                        SequentialAnimation {
                            NumberAnimation {
                                target: _Row;
                                property: "x";
                                duration: 340;
                                easing.type: Easing.OutCubic }
                        }
                    }
                ]

                function next()
                {
                    if(stateNumber < state.length)
                        stateNumber++
                }

                function previous()
                {
                    if(stateNumber > 0)
                        stateNumber--
                }
            }

            Row {
                id: _Row
                x: 0
                width: childrenRect.width
                height: parent.height
                BrowseList {
                    id: _RegionsList
                    onItemClicked: {
                        _CountriesList.model = dataObject.children
                        _StateGroup.next()
                        _Label_Header.text = dataObject.name
                    }
                }

                BrowseList {
                    id: _CountriesList
                    onItemClicked: {
                        __model.webRequest(dataObject.uri, function(response) {
                            _StateGroup.next()
                            _Label_Header.text = dataObject.name
                            _StatesList.model = response.children
                        })
                    }
                }

                BrowseList {
                    id: _StatesList
                    onItemClicked: {
                        __model.webRequest(dataObject.uri, function(response) {
                            _CitiesList.model = response.children.filter(function(e) {
                                return parseInt(e.entry_count, 10) > 0
                            })
                            _StateGroup.next()
                            _Label_Header.text = dataObject.name
                        })
                    }
                }

                BrowseList {
                    id: _CitiesList
                    onItemClicked: {
                        __model.webRequest(dataObject.entries_uri, function(response) {
                            _EntriesListView.model = response
                            _StateGroup.next()
                            _Label_Header.text = dataObject.name
                        })
                    }
                }

                EntriesListView {
                    id: _EntriesListView
                    width: _Item.width
                    height: _Item.height
                    showLocationDetail: true
                }
            }
        }
    }
}
