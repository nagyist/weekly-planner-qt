#ifndef WEEKDAY_H
#define WEEKDAY_H

#include <QObject>

class WeekDay : public QObject
{
    Q_OBJECT
public:
    explicit WeekDay(QObject *parent = 0);
    virtual ~WeekDay();
signals:

public slots:

};

#endif // WEEKDAY_H
