#ifndef DAYMODEL_H
#define DAYMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QVariant>
#include <QtCore/QList>

#include "timeslot.h"

static const int SLOTS_IN_A_DAY = 24;

class DayModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        StartTimeRole = Qt::UserRole+1,
        ItemDataRole,
        HourSpanRole,
        SetStartTimeRole,
        SetItemDataRole,
        SetHourSpanRole
      };
    static QHash<int, QByteArray> roleNames();
public:
    explicit DayModel(const QString& name, QObject *parent = 0);
    virtual ~DayModel();

    // Exposed to QML for changing the Cell text.
    Q_INVOKABLE void setItemData(int index, QString itemData);

public: // From QAbstractListModel
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant headerData( int section, Qt::Orientation orientation, int role = Qt::DisplayRole ) const;
    Qt::ItemFlags flags( const QModelIndex & index ) const;
    bool setData( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole );
public slots:
    bool setHourSpan(int index, int hourSpan);
private:
    QString m_dayName;
    QList<Timeslot*> m_items;
};

#endif // DAYMODEL_H
