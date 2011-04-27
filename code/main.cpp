#include <QtGui/QApplication>
#include <QtCore/QScopedPointer>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "weekmodel.h"
#include "daymodel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QScopedPointer<WeekModel> week(new WeekModel());
    QScopedPointer<DayModel> day(new DayModel());

    QmlApplicationViewer viewer;
    QDeclarativeContext* ctx = viewer.rootContext();
    ctx->setContextProperty("week", week.data());
    ctx->setContextProperty("testday", day.data());
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/weeklyplanner/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
