TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += qml.qrc

osx {
    QMAKE_MAC_SDK = macosx10.9
}

ios {
    LIBS += -framework MobileCoreServices
    LIBS += -framework MessageUI
    LIBS += -framework iAd
    LIBS += -framework AudioToolbox
    LIBS += -L/Users/niraj/SDK/QtEnterprise/5.3/ios/qml/st/app/models/ -lModelsPlugin
    LIBS += -L/Users/niraj/SDK/QtEnterprise/5.3/ios/qml/st/app/platform/ -lPlatformPlugin
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
