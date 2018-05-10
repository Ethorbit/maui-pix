QT += qml 
QT += quick 
QT += quickcontrols2
QT += sql
QT += widgets

CONFIG += ordered
CONFIG += c++11

TARGET = pix
TEMPLATE = app

DESTDIR = $$OUT_PWD/../

linux:unix:!android {
    message(Building for Linux KDE)
    include(kde/KDE.pri)

} else:android {
    message(Building helpers for Android)

    include(android/Android.pri)
    include(3rdparty/kirigami/kirigami.pri)
    DEFINES += STATIC_KIRIGAMI

} else {
    message("Unknown configuration")
}

include($$PWD/mauikit/mauikit.pri)

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    src/pix.cpp \
    src/db/db.cpp \
    src/db/dbactions.cpp

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    src/qml.qrc \
    assets.qrc \


HEADERS += \
    src/pix.h \
    src/db/fileloader.h \
    src/db/db.h \
    src/db/dbactions.h \
    src/utils/pic.h
