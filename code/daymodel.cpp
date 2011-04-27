#include "daymodel.h"
#include <QtCore/QVariant>

#include <QtCore/QDebug>

DayModel::DayModel(const QString& day, QObject *parent) :
    QAbstractListModel(parent), m_dayName(day), m_slots(SLOTS_IN_A_DAY)
{
    for (int i = 0; i < SLOTS_IN_A_DAY; i++) {
        Timeslot *slot = new Timeslot(QTime(i, 0, 0, 0));
        slot->setData("Testdata");
        m_slots[i] = slot;
    }
    setRoleNames(Timeslot::roleNames());
    qDebug() << "Slotcount: " << m_slots.count();
}

DayModel::~DayModel()
{
    for (int i = 0; i < m_slots.count(); i++) {
        Timeslot* slot = m_slots[i];
        m_slots[i] = 0;
        delete slot;
        slot = 0;
    }
    m_slots.clear();
}

int DayModel::rowCount(const QModelIndex &parent) const
{
    return m_slots.count();
}

QVariant DayModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid()) {
        int row = index.row();
        if (row >= 0 && row < m_slots.count()) {
            return m_slots[row]->data(role);
        } else {
            return QVariant("ERR: out-of-bounds");
        }
    } else {
        return QVariant("ERR: invalid idx");
    }
    return QVariant("ERR: other");
}

QVariant DayModel::headerData( int section, Qt::Orientation orientation, int role) const
{
    return QVariant(m_dayName);
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
