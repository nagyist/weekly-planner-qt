#ifndef WEEKMODEL_H
#define WEEKMODEL_H

#include <QtCore/QAbstractListModel>

class WeekModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit WeekModel(QObject *parent = 0);
    virtual ~WeekModel();

     int rowCount(const QModelIndex &parent = QModelIndex()) const;
     QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
};

#endif // WEEKMODEL_H
