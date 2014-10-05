import QtQuick 2.0

QtObject {

    function notice(rootObject, message)
    {
        console.trace()
        console.log(message)
    }

    function jsonDump(rootObject, jsonObject)
    {
        console.log(JSON.stringify(jsonObject, null, 2))
    }
}
