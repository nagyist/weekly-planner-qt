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
    Timeslot(int hourId, QTime start, QObject *parent = 0);
    virtual ~Timeslot();

    bool setStartTime(const QTime& time);
    bool setItemData(const QString& data);
    bool setHourSpan(int hours);
    bool setSpanStatus(bool spanned, int parentIndex);

    QString startTime() const;
    QString itemData() const;
    int hourSpan() const;

    QString toString() const;

    bool spanned() const;
    int parentIndex() const;
    int hourId() const;

private:
    int m_hourId;
    QTime m_start;
    QString m_data;
    int m_hours;

    bool m_spanned;
    int m_parentIndex;
};

#endif // TIMESLOT_H
