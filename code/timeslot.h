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
    Timeslot(QTime start, QObject *parent = 0);
    virtual ~Timeslot();

    bool setStartTime(const QTime& time);
    bool setItemData(const QString& data);
    bool setHourSpan(int hours);

    QString startTime() const;
    QString itemData() const;
    int hourSpan() const;

    QString toString() const;
private:
    QTime m_start;
    QString m_data;
    int m_hours;
};

#endif // TIMESLOT_H
