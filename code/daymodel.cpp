#include "daymodel.h"

#include <QtCore/QDebug>

QHash<int, QByteArray> DayModel::roleNames()
{
    QHash<int, QByteArray> roles;
    roles[StartTimeRole] = "startTime";
    roles[ItemDataRole] = "itemData";
    roles[HourSpanRole] = "hourSpan";
    return roles;
}

DayModel::DayModel(QObject *parent) :
    QAbstractListModel(parent), m_items()
{
    for (int i = 0; i < SLOTS_IN_A_DAY; i++) {
        Timeslot* slot = new Timeslot(QTime(i,0,0,0));
        m_items.append(slot);
        qDebug() << "Created slot" << slot->toString();
    }

    setRoleNames(DayModel::roleNames());
}

DayModel::~DayModel()
{
    //TODO cleanup
}

int DayModel::rowCount(const QModelIndex &parent) const
{
    return m_items.count();
}

QVariant DayModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid()) {
        int row = index.row();
        qDebug() << "Requested data at row" << row;
        if (row >= 0 && row < m_items.count()) {
            Timeslot* slot = m_items[row];
            if (role == StartTimeRole){
                return QVariant(slot->startTime());
            } else if (role == ItemDataRole) {
                return QVariant(slot->itemData());
            } else if (role == HourSpanRole) {
                return QVariant(slot->hourSpan());
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

QVariant DayModel::headerData( int section, Qt::Orientation orientation, int role) const
{
    return QVariant("HEADER");
}

Qt::ItemFlags DayModel::flags( const QModelIndex & index) const
{
    return Qt::ItemIsEnabled;
}

// For editing
bool DayModel::setData( const QModelIndex & index, const QVariant & value, int role)
{
    return true;
}
