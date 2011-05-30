#include "daymodel.h"

#include <QtCore/QDebug>

QHash<int, QByteArray> DayModel::roleNames()
{
    QHash<int, QByteArray> roles;
    roles[StartTimeRole] = "startTime";
    roles[ItemDataRole] = "itemData";
    roles[HourSpanRole] = "hourSpan";
    roles[SetStartTimeRole] = "setStartTime";
    roles[SetItemDataRole] = "setItemData";
    roles[SetHourSpanRole] = "setHourSpan";
    return roles;
}

DayModel::DayModel(const QString& name, QObject *parent) :
    QAbstractListModel(parent), m_dayName(name), m_items()
{
    QString templateItem("Day %1 Item %2");
    for (int i = 0; i < SLOTS_IN_A_DAY; i++) {
        Timeslot* slot = new Timeslot(QTime(i,0,0,0));
        slot->setItemData(templateItem.arg(m_dayName).arg(i));
        m_items.append(slot);
        qDebug() << "Created slot" << slot->toString();
    }
    setRoleNames(DayModel::roleNames());

    setHourSpan(9, 3);
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
        if (row >= 0 && row < m_items.count()) {
            Timeslot* slot = m_items[row];
            if (role == StartTimeRole){
                return QVariant(slot->startTime());
            } else if (role == ItemDataRole) {
                return QVariant(slot->itemData());
            } else if (role == HourSpanRole) {
                return QVariant(slot->hourSpan());
            } else {
                return QVariant("ERR: Unknown role for daymodel");
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
    if (!index.isValid())
        return 0;

    return Qt::ItemIsSelectable | Qt::ItemIsEnabled | Qt::ItemIsEditable;
}

// For editing
bool DayModel::setData( const QModelIndex & index, const QVariant & value, int role)
{
    // TODO IMPLEMENT THIS!
    qDebug() << "setData(), index" << index << "role" << role;

    if (index.isValid()) {
        int row = index.row();
        if (row >= 0 && row < m_items.count()) {
            Timeslot* slot = m_items[row];
            if (role == SetStartTimeRole){
                return slot->setStartTime(value.toTime());
            } else if (role == SetItemDataRole) {
                return slot->setItemData(value.toString());
            } else if (role == SetHourSpanRole) {
                return setHourSpan(row, value.toInt());
            } else {
                //return QVariant("ERR: Unknown role for daymodel");
                return false;
            }
        } else {
            //return QVariant("ERR: Invalid index");
            return false;
        }
    } else {
        //return QVariant("ERR: Invalid index");
        return false;
    }
    //return QVariant("ERR: other");
    return false;
}

bool DayModel::setHourSpan(int index, int hourSpan)
{
    bool retVal = false;
    if (index >= 0 && index < m_items.count()) {
        retVal = m_items[index]->setHourSpan(hourSpan);
    }

    for (int i = hourSpan-1; i > 0; i-- ) {
        m_items.removeAt(index+i);
    }

    return retVal;
}
