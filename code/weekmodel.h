#ifndef WEEKMODEL_H
#define WEEKMODEL_H

#include <QtCore/QAbstractListModel>

class WeekModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit WeekModel(QObject *parent = 0);
    virtual ~WeekModel();

public: // From QAbstractListModel
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant headerData( int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;

    Qt::ItemFlags flags( const QModelIndex & index) const;

    // For editing
    bool setData( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);
};

#endif // WEEKMODEL_H
