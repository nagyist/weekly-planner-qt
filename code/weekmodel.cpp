#include "weekmodel.h"
#include "timeslot.h"

#include <QtCore/QDebug>

QHash<int, QByteArray> WeekModel::roleNames()
{
    QHash<int, QByteArray> roles;
    roles[DayNameRole] = "dayName";
    roles[DayRole] = "day";
    return roles;
}

WeekModel::WeekModel(QObject *parent) :
    QAbstractListModel(parent), m_days()
{
    for (int i = 0; i < DAYS_IN_WEEK; i++) {
        Day* day = new Day(DAY_NAMES[i], this);
        m_days.append(day);
        qDebug() << "Created day" << day->dayName();
    }
    setRoleNames(WeekModel::roleNames());
}

WeekModel::~WeekModel()
{
    //TODO cleanup
}

int WeekModel::rowCount(const QModelIndex &parent) const
{
    return m_days.count();
}

QVariant WeekModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid()) {
        int row = index.row();
        qDebug() << "Requested day for column" << row;
        if (row >= 0 && row < m_days.count()) {
            Day* day = m_days[row];
            if (role == DayNameRole){
                return QVariant(day->dayName());
            } else {
                return QVariant("ERR: Unknown role for weekmodel");
            }
        } else {
            return QVariant("ERR: Invalid index");
        }
    } else {
        return QVariant("ERR: Invalid index");
    }
    return QVariant("ERR: other");
}

QVariant WeekModel::headerData( int section, Qt::Orientation orientation, int role) const
{
    return QVariant("HEADER");
}

Qt::ItemFlags WeekModel::flags( const QModelIndex & index) const
{
    return Qt::ItemIsEnabled;
}

// For editing
bool WeekModel::setData( const QModelIndex & index, const QVariant & value, int role)
{
    return true;
}

QObject* WeekModel::day(int index) const
{
    qDebug() << "Requesting day for index" << index;
    if (index >= 0 && index < m_days.count()) {
        return m_days.at(index);
    }
    return 0;
}
