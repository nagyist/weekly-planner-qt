#include <QtGui/QApplication>
#include <QtCore/QScopedPointer>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "weekmodel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    // Set this attribute in order to avoid drawing the system
    // background unnecessary.
    // TODO: If need be to variate this between S^3 and 5.0 devices, this will
    // need to be variated run-time (e.g. with QDeviceInfo::Version())!
    viewer.setAttribute(Qt::WA_NoSystemBackground);

    QDeclarativeContext* ctx = viewer.rootContext();
    QScopedPointer<WeekModel> week(new WeekModel());
    ctx->setContextProperty("week", week.data());

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/weeklyplanner/main.qml"));
#ifdef QT_SIMULATOR
    viewer.showFullScreen();
#else
    viewer.showExpanded();
#endif

    return app.exec();
}
