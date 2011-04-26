#ifndef WEEKMODEL_H
#define WEEKMODEL_H

#include <QObject>

class WeekModel : public QObject
{
    Q_OBJECT
public:
    explicit WeekModel(QObject *parent = 0);
    virtual ~WeekModel();
signals:

public slots:

};

#endif // WEEKMODEL_H
