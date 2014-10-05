#include <QApplication>
#include <QQmlApplicationEngine>

#define QML_DEVELOPMENT "qrc:/qml/dev.qml"
#define SIM false

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QString mainQml = QStringLiteral(QML_DEVELOPMENT);

#ifdef Q_OS_IOS
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
