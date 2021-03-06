#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#ifdef Q_OS_IOS
#include "location.h"
#endif

#define QML_DEVELOPMENT "qrc:/qml/dev.qml"
#define SIM false


//class Pos : public QObject
//{
//    Q_OBJECT
//public:
//    Pos(QObject *parent = 0)
//        : QObject(parent)
//    {
//        QGeoPositionInfoSource *source = QGeoPositionInfoSource::createDefaultSource(this);
//        qDebug() << source->error();
//        if (source) {
//            qDebug() << source->availableSources();
//            connect(source, SIGNAL(positionUpdated(QGeoPositionInfo)),
//                    this, SLOT(positionUpdated(QGeoPositionInfo)));
//            source->setUpdateInterval(5000);
//            source->startUpdates();
//        }
//    }

//    ~Pos() { }

//private slots:
//    void positionUpdated(const QGeoPositionInfo &info)
//    {
//        qDebug() << "Position updated:" << info;
//    }
//};


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QString mainQml = QStringLiteral(QML_DEVELOPMENT);

#ifdef Q_OS_IOS
    qmlRegisterType<Location>("st.app", 1, 0, "Location");
    mainQml = QStringLiteral("qrc:/qml/main.qml");
#elif defined(Q_OS_ANDROID)
    mainQml = QStringLiteral("qrc:/qml/main_android.qml");
#elif SIM
    QCursor cursor(QPixmap(":/qml/img/sim/cursor-default.png"));
    app.setOverrideCursor(cursor);
    mainQml = QStringLiteral("qrc:/qml/simfinger.qml");
#endif

    engine.load(QUrl(mainQml));

    return app.exec();
}

//#include "main.moc"
