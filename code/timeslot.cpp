#include "timeslot.h"
#include <QtCore/QDebug>

Timeslot::Timeslot(QTime start, QObject *parent) :
    QObject(parent), m_start(start), m_data("-"), m_hours(1)
{
}

Timeslot::~Timeslot()
{
}

void Timeslot::setStartTime(QTime& time)
{
    if (time != m_start) {
        m_start = time;
        emit dataChanged();
    }
}

void Timeslot::setItemData(const QString& data)
{
    if (data != m_data) {
        m_data = data;
        qDebug() << "Item data changed to: " << data;
        emit dataChanged();
    }
}

void Timeslot::setHourSpan(int hours)
{
    if (hours != m_hours) {
        m_hours = hours;
        emit dataChanged();
    }
}

QString Timeslot::startTime() const
{
    return m_start.toString("HH:mm");
}

QString Timeslot::itemData() const
{
    return m_data;
}

int Timeslot::hourSpan() const
{
    return m_hours;
}

QString Timeslot::toString() const
{
    return startTime() + ": " + itemData();
}
