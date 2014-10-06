import QtQuick 2.0

Item {
    id: root

    property string packageName : "st.app.vegguide"
    property string identifier : "VegGuide"
    property string version : "0.0.1"
    property string email : "support+vegguide@app.st"

    property url apiTest :  "http://appstreet.local/vg/test.json"
    property url apiTestEngland : "http://www.vegguide.org/search/by-lat-long/51.5033630,-0.1276250"

    property variant apiRegion : {
        "url" : "http://www.vegguide.org/",
        "headers" : {
            "Type" : "application/vnd.vegguide.org-regions+json"
        }
    }

    property url apiRecent : "http://appstreet.local/vg/recent.xml"


    StateGroup {
        states: [
            State {
                when: Qt.platform.os === "ios"
                PropertyChanges {
                    target: root
                    apiRecent: "http://www.vegguide.org/site/recent.rss"
                    apiTest: apiTestEngland
                }
            }
        ]
    }


}
