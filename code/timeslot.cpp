#include "timeslot.h"

QHash<int, QByteArray> Timeslot::roleNames()
{
    QHash<int, QByteArray> roles;
    roles[StartTimeRole] = "startTime";
    roles[ItemDataRole] = "itemData";
    roles[ItemSpanRole] = "hourSpan";
    return roles;
}

Timeslot::Timeslot(QTime start, QObject *parent) :
    QObject(parent), m_start(start), m_data("-"), m_hours(1)
{
}

Timeslot::~Timeslot()
{
}

void Timeslot::setData(const QString& data)
{
    if (data != m_data) {
        m_data = data;
        emit dataChanged();
    }
}

void Timeslot::setSpan(int hours)
{
    if (hours != m_hours) {
        m_hours = hours;
        emit dataChanged();
    }
}

QVariant Timeslot::data(int role) const
{
    switch (role) {
    case StartTimeRole:
        return QVariant(m_start.toString());
    case ItemDataRole:
        return QVariant(m_data);
    case ItemSpanRole:
        return QVariant(m_hours);
    default:
        return QVariant();
    }
}

QString Timeslot::toString() const
{
    QString time = m_start.toString("HH:mm");
    return time;
}

QString Timeslot::startTime() const
{
    return m_start.toString("HH:mm");
}

QString Timeslot::itemData() const
{
    return m_data;
}
