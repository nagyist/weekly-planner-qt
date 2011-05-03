#ifndef WEEKMODEL_H
#define WEEKMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

#include "timeslot.h"
#include "day.h"

// Constants
static const int DAYS_IN_WEEK = 7;
static const char* DAY_NAMES[DAYS_IN_WEEK] = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" };

class WeekModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        DayNameRole = Qt::UserRole+1
      };
    static QHash<int, QByteArray> roleNames();
public:
    explicit WeekModel(QObject *parent = 0);
    virtual ~WeekModel();
public: // From QAbstractListModel
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant headerData( int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    Qt::ItemFlags flags( const QModelIndex & index) const;
    bool setData( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);
public:
    Q_INVOKABLE QObject* day(int index) const;

private:
    QList<Day*> m_days;
};

#endif // WEEKMODEL_H
