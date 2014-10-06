import QtQuick 2.3
import "utils" as Utils
import "views" as Views
import QtPositioning 5.2 as Positioning

Rectangle {
    id: root
    color: "#ffffff"

    property alias log : _Log
    Utils.Log { id: _Log }

    property alias __theme : _Theme
    property alias theme : _Theme
    Utils.Theme { id: _Theme }

    property alias config : _Config
    Utils.Config { id: _Config }

    property alias model : _Model
    Utils.Model { id: _Model }



//    Positioning.PositionSource {
//        id: src
//        updateInterval: 1000
//        active: true

//        onPositionChanged: {
//            var coord = src.position.coordinate;
//            console.log("Coordinate:", coord.longitude, coord.latitude);
//        }

//        onValidChanged: {
//            log.notice(root, "valid = " + valid)
//        }
//        Component.onCompleted: {

//        }
//    }

    Item {
        id: _Item_PageContainer
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: _TabBarController.top
        clip: true
        Behavior on scale { NumberAnimation { duration: 350; easing.type: Easing.OutCubic} }

        Views.Recent {
            id: _Recent
            controller: _TabBarController
        }

        Views.Nearby {
            id: _Nearby
            controller: _TabBarController
        }
    }

    Views.TabBarController {
        id: _TabBarController
    }
}
