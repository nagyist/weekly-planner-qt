#ifndef WEEKMODEL_H
#define WEEKMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QVector>

#include "dayitem.h"
#include "daymodel.h"

static const int DAYS_IN_WEEK = 7;
static const char* DAY_NAMES[DAYS_IN_WEEK] = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" };

class WeekModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit WeekModel(QObject *parent = 0);
    virtual ~WeekModel();
public:
    Q_INVOKABLE DayItem* day(int index) const;
public: // From QAbstractListModel
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant headerData( int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;

    Qt::ItemFlags flags( const QModelIndex & index) const;

    // For editing
    bool setData( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);
private:
    QVector<DayItem*> m_days;
};

#endif // WEEKMODEL_H
