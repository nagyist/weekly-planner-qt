#include "timeslot.h"

Timeslot::Timeslot(QTime start, QObject *parent) :
    QObject(parent), m_start(start)
{
}

Timeslot::~Timeslot()
{

}
