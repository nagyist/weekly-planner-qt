#include "daymodel.h"

#include <QtCore/QDebug>

QHash<int, QByteArray> DayModel::roleNames()
{
    QHash<int, QByteArray> roles;
    roles[StartTimeRole] = "startTime";
    roles[ItemDataRole] = "itemData";
    roles[HourSpanRole] = "hourSpan";
    roles[SpannedRole] = "spanned";
    roles[HourIdRole] = "hourId";

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
        Timeslot* slot = new Timeslot(i, QTime(i,0,0,0));
        connect(slot, SIGNAL(dataChanged()), this, SLOT(handleItemChange()));
        slot->setItemData(templateItem.arg(m_dayName).arg(i));
        m_items.append(slot);
        qDebug() << "Created slot" << slot->toString();
    }
    setRoleNames(DayModel::roleNames());

//    // Sets the seed within the range 0-999
//    qsrand(QTime::currentTime().msec());
//    // Set 0 to 3 spans / day
//    for (int i = qrand() % 4; i > 0; i--) {
//        setHourSpan(qrand() % 24, (qrand() % 3) + 2);
//    }
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
            } else if (role == SpannedRole) {
                return QVariant(slot->spanned());
            } else if (role == HourIdRole) {
                return QVariant(slot->hourId());
            } else {
                return QVariant("ERR: Unknown role for daymodel: " + role);
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

void DayModel::handleItemChange()
{
    Timeslot* item = static_cast<Timeslot*>(sender());
    QModelIndex modelIndex = indexFromItem(item);
    if(modelIndex.isValid()) {
        qDebug() << "Now emitting dataChanged(index, index)!";
        emit dataChanged(modelIndex, modelIndex);
    }
}

QModelIndex DayModel::indexFromItem(const Timeslot* item) const
{
  Q_ASSERT(item);
  for(int row=0; row<m_items.size(); ++row) {
    if(m_items.at(row) == item) return index(row);
  }
  return QModelIndex();
}

bool DayModel::setHourSpan(int index, int hourSpan)
{
    bool retVal = false;
    if (index >= 0 && index < m_items.count()) {
        retVal = m_items[index]->setHourSpan(hourSpan);
    }

    for (int i = hourSpan-1; i > 0; i-- ) {
        //m_items.removeAt(index+i);
        m_items[index+i]->setSpanStatus(true, index);
    }

    return retVal;
}

void DayModel::setItemData(int index, QString itemData)
{
    if (index >= 0 && index < m_items.count()) {
        m_items[index]->setItemData(itemData);
    }
}

void DayModel::mergeDown(int index)
{
    if (index == m_items.count()-1) {
        qDebug() << "Cannot span downwards!";
    }
    else if (index >= 0 && index < m_items.count()-1) {
        // Check that we're not spanning on already spanned hours!
        int oldHourSpan = m_items[index]->hourSpan();
        if (m_items[index+oldHourSpan]->hourSpan() > 1) {
            qDebug() << "Cannot span on already spanned hours! Please split first!";
        } else {
            m_items[index]->setHourSpan(oldHourSpan+1);
            // Set the next item beneath the spanned item as newly spanned!
            m_items[index+oldHourSpan]->setSpanStatus(true, index);
        }
    } else {
        qDebug() << "Something went severely wrong!";
    }
}

void DayModel::mergeUp(int index)
{
    qDebug() << "DayModel::mergeUp! Index:" << index;
    if (index == 0) {
        qDebug() << "Cannot span upwards!";
    } else if (index > 0 && index < m_items.count()) {
        // Get the previous item, as the hourSpan must be set to it.
        int parentIndex = m_items[index]->parentIndex();
        qDebug() << "parentIndex:" << parentIndex;
        if (parentIndex != -1) {
            qDebug() << "parentIndex != -1 -branch!" << parentIndex;
            // The item was already spanned, use the given parent index as
            // starting point for the hourSpan.
            int oldHourSpan = m_items[parentIndex]->hourSpan();
            m_items[parentIndex]->setHourSpan(oldHourSpan+1);
            // Set the currently selected item's spanStatus as true.
            m_items[index]->setSpanStatus(true, parentIndex);
        } else {
            qDebug() << "parentIndex == -1!" << parentIndex;
            // The item hasn't been spanned before, the given index is valid.
            int oldHourSpan = m_items[index]->hourSpan();
            m_items[index-1]->setHourSpan(oldHourSpan+1);
            // Reset the span hour count for the current item and set it to
            // be spanned.
            m_items[index]->setHourSpan(1);
            m_items[index]->setSpanStatus(true, index);
        }

    } else {
        qDebug() << "Something went severely wrong!";
    }
}

void DayModel::split(int index)
{
    if (index >= 0 && index < m_items.count()) {
        int hourSpan = m_items[index]->hourSpan();
        m_items[index]->setHourSpan(1);
        for (int i = index; i < index+hourSpan; i++ ) {
            m_items[i]->setSpanStatus(false, -1);
        }
    }
}
