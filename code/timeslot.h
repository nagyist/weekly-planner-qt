#ifndef TIMESLOT_H
#define TIMESLOT_H

#include <QtCore/QObject>
#include <QtCore/QTime>

class Timeslot : public QObject
{
    Q_OBJECT
public:
    Timeslot(QTime start = QTime(), QObject *parent = 0);
    virtual ~Timeslot();

signals:

public slots:

private:
    QTime m_start;

};

#endif // TIMESLOT_H
