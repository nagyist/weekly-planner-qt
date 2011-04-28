#include "weekmodel.h"
#include "daymodel.h"

WeekModel::WeekModel(QObject *parent) :
    QAbstractListModel(parent), m_days(DAYS_IN_WEEK)
{
    for (int i = 0; i < DAYS_IN_WEEK; i++) {
        DayModel *day = new DayModel(DAY_NAMES[i]);
        m_days[i] = day;
    }
    setRoleNames(DayModel::roleNames());
}

WeekModel::~WeekModel()
{
    for (int i = 0; i < m_days.count(); i++) {
        DayModel* day = m_days[i];
        m_days[i] = 0;
        delete day;
        day = 0;
    }
    m_days.clear();
}

int WeekModel::rowCount(const QModelIndex &parent) const
{
    return m_days.count();
}

QVariant WeekModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid()) {
        int row = index.row();
        if (row >= 0 && row < m_days.count()) {
            return m_days[row]->data(index, role);
            //return m_days[row]->headerData(0, Qt::Horizontal);
        } else {
            return QVariant("ERR: out-of-bounds");
        }
    } else {
        return QVariant("ERR: invalid idx");
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
