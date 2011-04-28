#include <QtGui/QApplication>
#include <QtCore/QScopedPointer>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "weekmodel.h"
#include "daymodel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    QDeclarativeContext* ctx = viewer.rootContext();

    QScopedPointer<WeekModel> week(new WeekModel());
    ctx->setContextProperty("week", week.data());

//    QScopedPointer<DayModel> mon(new DayModel("Monday"));
//    QScopedPointer<DayModel> tue(new DayModel("Tuesday"));
//    QScopedPointer<DayModel> wed(new DayModel("Wednesday"));
//    QScopedPointer<DayModel> thu(new DayModel("Thursday"));
//    QScopedPointer<DayModel> fri(new DayModel("Friday"));
//    ctx->setContextProperty("monday", mon.data());
//    ctx->setContextProperty("tuesday", tue.data());
//    ctx->setContextProperty("wednesday", wed.data());
//    ctx->setContextProperty("thursday", thu.data());
//    ctx->setContextProperty("friday", fri.data());

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/weeklyplanner/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
