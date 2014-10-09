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



    //    Utils.ClickGuard {
    //        z: 100000
    //        onClicked: {
    //            log.notice(root, "clicked....")

    //        }
    //    }

    Positioning.PositionSource {
        id: src
        updateInterval: 60000
        active: true

        onPositionChanged: {
            var coord = src.position.coordinate;
            console.log("Coordinate:", coord.latitude, coord.longitude);
            config.latitude = String(coord.latitude)
            config.longitude = String(coord.longitude)
            stop()
        }

        onValidChanged: {
            log.notice(root, "valid = " + valid)
        }
        Component.onCompleted: {
            try {
                _Location.requestAlwaysAuthorization()
            } catch (ex)
            {

            }
        }
    }

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
        z: 2
    }

    Views.TabBarController {
        id: _TabBarController
        z: 3
    }

    Views.RestaurantSheet {
        id: _RestaurantSheet
        z: 4
    }
}
