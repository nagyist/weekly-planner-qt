#ifndef DAYITEM_H
#define DAYITEM_H

#include <QtCore/QObject>

#include "daymodel.h"

class DayItem : public QObject
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole+1,
        TitleRole
    };
    static QHash<int, QByteArray> roleNames();
public:
    DayItem(const QString& day, QObject *parent = 0);
    virtual ~DayItem();

    QVariant data(int role) const;
private:
    QString m_dayName;
    DayModel* m_model;

};

#endif // DAYITEM_H
