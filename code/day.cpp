#include "day.h"
#include "timeslot.h"

#include <QtCore/QDebug>

Day::Day(const QString& name, QObject *parent) :
    QObject(parent), m_dayName(name)
{
    m_model = new DayModel(m_dayName, this);
}

Day::~Day()
{
    delete m_model;
}

QObject* Day::items() const
{
    qDebug() << "Requested items. We have" << m_model->rowCount();
    return m_model;
}

QString Day::dayName() const
{
    return m_dayName;
}
