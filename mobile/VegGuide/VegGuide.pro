TEMPLATE = app

QT += qml quick widgets sql network multimedia xml
QT += positioning

SOURCES += main.cpp

RESOURCES += qml.qrc

osx {
    QMAKE_MAC_SDK = macosx10.9
}

ios {
#    BUNDLE_DATA.files = $$PWD/ios/AppIcon29x29.png \
#$$PWD/ios/AppIcon29x29@2x.png \
#$$PWD/ios/AppIcon40x40.png \
#$$PWD/ios/AppIcon40x40@2x.png \
#$$PWD/ios/AppIcon50x50.png \
#$$PWD/ios/AppIcon50x50@2x.png \
#$$PWD/ios/AppIcon57x57.png \
#$$PWD/ios/AppIcon57x57@2x.png \
#$$PWD/ios/AppIcon60x60.png \
#$$PWD/ios/AppIcon60x60@2x.png \
#$$PWD/ios/AppIcon72x72.png \
#$$PWD/ios/AppIcon72x72@2x.png \
#$$PWD/ios/AppIcon76x76.png \
#$$PWD/ios/AppIcon76x76@2x.png \
#$$PWD/ios/Default-568h@2x.png \
#$$PWD/ios/Default-480h@2x.png
#$$PWD/ios/Default.png
    QMAKE_BUNDLE_DATA += BUNDLE_DATA
    QMAKE_INFO_PLIST = $$PWD/ios/Info.plist
    #QMAKE_IOS_TARGETED_DEVICE_FAMILY = 1

    LIBS += -framework Foundation
    LIBS += -framework MobileCoreServices
    LIBS += -framework MessageUI
    LIBS += -framework iAd
    LIBS += -framework AudioToolbox
    LIBS += -framework CoreLocation
    LIBS += -L/Users/niraj/SDK/QtEnterprise/5.3/ios/qml/st/app/models/ -lModelsPlugin
    LIBS += -L/Users/niraj/SDK/QtEnterprise/5.3/ios/qml/st/app/platform/ -lPlatformPlugin

OBJECTIVE_SOURCES += \
    location.mm

HEADERS += \
    location.h


}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)


