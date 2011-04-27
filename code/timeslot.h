#ifndef TIMESLOT_H
#define TIMESLOT_H

#include <QtCore/QObject>
#include <QtCore/QTime>
#include <QtCore/QVariant>
#include <QtCore/QHash>

class Timeslot : public QObject
{
    Q_OBJECT
signals:
      void dataChanged();
public:
    enum Roles {
        NameRole = Qt::UserRole+1,
        StartTimeRole
      };

    static QHash<int, QByteArray> roleNames();
public:
    Timeslot(QTime start, QObject *parent = 0);
    virtual ~Timeslot();

    void setData(const QString& data);
    QVariant data(int role) const;
signals:

public slots:

private:
    QTime m_start;
    QString m_data;

};

#endif // TIMESLOT_H
