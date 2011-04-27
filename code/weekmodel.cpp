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
    return 0;
}

QVariant WeekModel::data(const QModelIndex &index, int role) const
{
    return QVariant();
}
