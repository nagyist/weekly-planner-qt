#ifndef DAY_H
#define DAY_H

#include <QtCore/QObject>
#include <QtCore/QTime>
#include <QtCore/QVariant>
#include <QtCore/QHash>

#include "daymodel.h"

class Day : public QObject
{
    Q_OBJECT
signals:
      void dataChanged();
public:
    enum Roles {
        ItemDataRole = Qt::UserRole+1
      };

    static QHash<int, QByteArray> roleNames();
public:
    Day(const QString& name, QObject *parent = 0);
    virtual ~Day();

    void setData(const QString& data);
    QVariant data(int role) const;

public slots:
    QObject* items() const;
    QString dayName() const;
private:
    QString m_dayName;
    DayModel* m_model;
};

#endif // DAY_H
