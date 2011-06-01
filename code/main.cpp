#include <QtGui/QApplication>
#include <QtCore/QScopedPointer>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "weekmodel.h"
#include "tablecell.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    QDeclarativeContext* ctx = viewer.rootContext();

    qmlRegisterType<TableCell>("Templates", 1, 0, "TableCell");

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
