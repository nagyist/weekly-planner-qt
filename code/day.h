#ifndef DAY_H
#define DAY_H

#include <QtCore/QObject>
#include <QtCore/QString>

#include "daymodel.h"

class Day : public QObject
{
    Q_OBJECT
public:
    Day(const QString& name, QObject *parent = 0);
    virtual ~Day();

public slots:
    QObject* items() const;
    QString dayName() const;
private:
    QString m_dayName;
    DayModel* m_model;
};

#endif // DAY_H
