#include "weekmodel.h"
#include "daymodel.h"

WeekModel::WeekModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

WeekModel::~WeekModel()
{
}


int WeekModel::rowCount(const QModelIndex &parent) const
{
    return 5;
}

QVariant WeekModel::data(const QModelIndex &index, int role) const
{
    return QVariant("DAY");
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
