#include "daymodel.h"
#include <QtCore/QVariant>

DayModel::DayModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

DayModel::~DayModel()
{
}

int DayModel::rowCount(const QModelIndex &parent) const
{
    return 10;
}

QVariant DayModel::data(const QModelIndex &index, int role) const
{
    return QVariant("Testdata");
}

QVariant DayModel::headerData( int section, Qt::Orientation orientation, int role) const
{
    return QVariant("Monday");
}

Qt::ItemFlags DayModel::flags( const QModelIndex & index) const
{
    return Qt::ItemIsEditable;
}


// For editing
bool DayModel::setData( const QModelIndex & index, const QVariant & value, int role)
{
    return true;
}
