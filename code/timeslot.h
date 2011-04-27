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
        StartTimeRole = Qt::UserRole+1,
        ItemDataRole,
        ItemSpanRole
      };

    static QHash<int, QByteArray> roleNames();
public:
    Timeslot(QTime start, QObject *parent = 0);
    virtual ~Timeslot();

    void setData(const QString& data);
    void setSpan(int hours);
    QVariant data(int role) const;
signals:

public slots:

private:
    QTime m_start;
    int m_hours;
    QString m_data;

};

#endif // TIMESLOT_H
