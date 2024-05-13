#include <QCoreApplication>
#include <QtQml>
#include <QtCore>
#include <QColor>
#include <QDebug>
#include <QObject>
#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "rosnode.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    rclcpp::init(argc, argv);
    QQmlContext* context;
    QQmlApplicationEngine engine;
    RosNode node;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    context = engine.rootContext();
    context->setContextProperty("_rosNode", &node);
    engine.load(url);
    return app.exec();
}
