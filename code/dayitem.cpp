#include "dayitem.h"


QHash<int, QByteArray> DayItem::roleNames()
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[TitleRole] = "title";
    return roles;
}

DayItem::DayItem(const QString& day, QObject *parent) :
    QObject(parent), m_dayName(day)
{
    m_model = new DayModel();
}

DayItem::~DayItem()
{
    delete m_model;
}

QVariant DayItem::data(int role) const
{
    switch (role) {
    case IdRole:
        return QVariant("ID");
    case TitleRole:
        return QVariant(m_dayName);
    default:
        return QVariant("DAYITEM UNKNOWN ROLE");
    }

}
