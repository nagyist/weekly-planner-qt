#include "day.h"
#include "timeslot.h"

#include <QtCore/QDebug>

QHash<int, QByteArray> Day::roleNames()
{
    QHash<int, QByteArray> roles;
    roles[ItemDataRole] = "itemData";
    return roles;
}

Day::Day(const QString& name, QObject *parent) :
    QObject(parent), m_dayName(name)
{
    m_model = new DayModel(m_dayName, this);
}

Day::~Day()
{
    delete m_model;
}

void Day::setData(const QString& data)
{
    if (data != m_dayName) {
        m_dayName = data;
        emit dataChanged();
    }
}


QVariant Day::data(int role) const
{
    switch (role) {
    case ItemDataRole:
        return QVariant(dayName());
    default:
        return QVariant("ERR: Unknown role");
    }
}

QObject* Day::items() const
{
    qDebug() << "Requested items. We have" << m_model->rowCount();
    return m_model;
}

QString Day::dayName() const
{
    return m_dayName;
}
