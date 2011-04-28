#include "daymodel.h"
#include <QtCore/QVariant>

#include <QtCore/QDebug>

QHash<int, QByteArray> DayModel::roleNames()
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    return roles;
}

DayModel::DayModel(const QString& day, QObject *parent) :
    QAbstractListModel(parent), m_dayName(day), m_slots(SLOTS_IN_A_DAY)
{
    populate();
    qDebug() << "Created DayModel" << m_dayName;
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
        if (role == TitleRole) {
            return QVariant(m_dayName);
        } else {
            int row = index.row();
            if (row >= 0 && row < m_slots.count()) {
                return m_slots[row]->data(role);
            } else {
                return QVariant("ERR: out-of-bounds");
            }
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

void DayModel::populate()
{
    for (int i = 0; i < SLOTS_IN_A_DAY;) {
        Timeslot *slot = new Timeslot(QTime(i, 0, 0, 0));
        slot->setData(m_dayName);
        m_slots[i++] = slot;
    }
    setRoleNames(Timeslot::roleNames());
    m_slots[9]->setSpan(2);
    m_slots.remove(10);
}
