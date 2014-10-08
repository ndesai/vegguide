#ifndef LOCATION_H
#define LOCATION_H

#include <QQuickItem>
#include <QDateTime>
#define DEBUG if(1) qDebug() << QDateTime::currentDateTime().toString("dd/MM/yyyy hh:mm:ss:zzz") <<  __PRETTY_FUNCTION__

class Location : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(double longitude READ longitude WRITE setLongitude NOTIFY longitudeChanged)
    Q_PROPERTY(double latitude READ latitude WRITE setLatitude NOTIFY latitudeChanged)

public:
    explicit Location(QQuickItem *parent = 0);

    double longitude() const
    {
        return m_longitude;
    }

    double latitude() const
    {
        return m_latitude;
    }

    Q_INVOKABLE void requestAlwaysAuthorization();
    Q_INVOKABLE void requestWhenInUseAuthorization();

signals:

    void longitudeChanged(double arg);

    void latitudeChanged(double arg);

public slots:

void setLongitude(double arg)
{
    if (m_longitude == arg)
        return;

    m_longitude = arg;
    emit longitudeChanged(arg);
}

void setLatitude(double arg)
{
    if (m_latitude == arg)
        return;

    m_latitude = arg;
    emit latitudeChanged(arg);
}

private:
void *m_delegate;
double m_longitude;
double m_latitude;
};

#endif // LOCATION_H
