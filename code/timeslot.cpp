#include "timeslot.h"

Timeslot::Timeslot(QTime start, QObject *parent) :
    QObject(parent), m_start(start), m_data("-")
{
}

Timeslot::~Timeslot()
{

}

QHash<int, QByteArray> Timeslot::roleNames()
{
    QHash<int, QByteArray> roles;
    roles[StartTimeRole] = "startTime";
    roles[ItemDataRole] = "itemData";
    return roles;
}

void Timeslot::setData(const QString& data)
{
    m_data = data;
    emit dataChanged();
}

QVariant Timeslot::data(int role) const
{
    switch (role) {
    case StartTimeRole:
        return QVariant(m_start.toString());
    case ItemDataRole:
        return QVariant(m_data);
    default:
        return QVariant();
    }
}
