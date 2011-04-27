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

    QScopedPointer<DayModel> day(new DayModel("Monday"));
    ctx->setContextProperty("testday", day.data());

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/weeklyplanner/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
