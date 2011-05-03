#include <QtGui/QApplication>
#include <QtCore/QScopedPointer>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "weekmodel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    QDeclarativeContext* ctx = viewer.rootContext();

    QScopedPointer<WeekModel> week(new WeekModel());
    ctx->setContextProperty("week", week.data());

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/weeklyplanner/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
