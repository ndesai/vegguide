import QtQuick 2.3

Image {
    property bool ready : status===Image.Ready
    cache: false;
    asynchronous: true
    opacity: 0
    onStatusChanged: {
        if(status == Image.Ready)
        {
            opacity = 1.0;
        }
    }
    Behavior on opacity { NumberAnimation{ duration: 150; } }
}
