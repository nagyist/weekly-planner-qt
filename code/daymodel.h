#ifndef DAYMODEL_H
#define DAYMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QVariant>
#include <QtCore/QList>

#include "timeslot.h"

static const int DAYS_FIRST_SLOT = 6;
static const int SLOTS_IN_A_DAY = 20;

class DayModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        StartTimeRole = Qt::UserRole+1,
        ItemDataRole,
        HourSpanRole,
        SpannedRole,
        HourIdRole,

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
    Q_INVOKABLE void mergeDown(int index);
    Q_INVOKABLE void mergeUp(int index);
    Q_INVOKABLE void split(int index);

public: // From QAbstractListModel
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant headerData( int section, Qt::Orientation orientation, int role = Qt::DisplayRole ) const;
    Qt::ItemFlags flags( const QModelIndex & index ) const;
    bool setData( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole );
public slots:
    bool setHourSpan(int index, int hourSpan);
    void handleItemChange();

private: // Methods
    void setSpanStatus(bool spanned, int index, int parentIndex);
    QModelIndex indexFromItem(const Timeslot* item) const;

private:
    QString m_dayName;
    QList<Timeslot*> m_items;
};

#endif // DAYMODEL_H
