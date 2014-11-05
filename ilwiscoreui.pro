QMAKE_CXXFLAGS += -std=c++11
QMAKE_CXXFLAGS += -Wno-unused-parameter
QMAKE_CXXFLAGS += -Wno-sign-compare
QMAKE_CXXFLAGS += -Wno-unused-local-typedefs
QMAKE_CXXFLAGS += -Wno-deprecated-declarations

TEMPLATE = lib
TARGET = ilwiscoreui
QT += qml quick sql network
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)

CONFIG(debug, debug|release) {
CONF=debug
}

CONFIG(release, debug|release) {
CONF=release
}

PLATFORM = generic
win32{
    PLATFORM = win32
}

include(deployment.pri)

# Add more folders to ship with the application, here
folder_01.source = ilwiscoreui/qml
folder_01.target = ../../../output/$$PLATFORM$$CONF/bin/extensions/$$TARGET
DEPLOYMENTFOLDERS = folder_01

# Input
SOURCES += \
    ilwiscoreui/ilwiscoreui_plugin.cpp \
    ilwiscoreui/ilwiscoreui.cpp \
    ilwiscoreui/models/catalogfiltermodel.cpp \
    ilwiscoreui/models/catalogmodel.cpp \
    ilwiscoreui/models/catalogscontroller.cpp \
    ilwiscoreui/models/ilwisobjectmodel.cpp \
    ilwiscoreui/models/mastercatalogmodel.cpp \
    ilwiscoreui/models/objectvisualizationmodel.cpp \
    ilwiscoreui/models/operationcatalogmodel.cpp \
    ilwiscoreui/models/operationmodel.cpp \
    ilwiscoreui/models/resourcemodel.cpp \
    ilwiscoreui/models/tranquilizerhandler.cpp \
    ilwiscoreui/models/usermessagehandler.cpp \
    ilwiscoreui/models/visualizationmanager.cpp \
    ilwiscoreui/applicationformexpressionparser.cpp \
    ilwiscoreui/ilwistype.cpp

HEADERS += \
    ilwiscoreui/ilwiscoreui_plugin.h \
    ilwiscoreui/ilwiscoreui.h \
    ilwiscoreui/models/catalogfiltermodel.h \
    ilwiscoreui/models/catalogmodel.h \
    ilwiscoreui/models/catalogscontroller.h \
    ilwiscoreui/models/ilwisobjectmodel.h \
    ilwiscoreui/models/mastercatalogmodel.h \
    ilwiscoreui/models/objectvisualizationmodel.h \
    ilwiscoreui/models/operationcatalogmodel.h \
    ilwiscoreui/models/operationmodel.h \
    ilwiscoreui/models/resourcemodel.h \
    ilwiscoreui/models/tranquilizerhandler.h \
    ilwiscoreui/models/usermessagehandler.h \
    ilwiscoreui/models/visualizationmanager.h \
    ilwiscoreui/applicationformexpressionparser.h \
    ilwiscoreui/ilwistype.h

LIBS += -L$$PWD/../libraries/$$PLATFORM$$CONF/ -lilwiscore
LIBS += -L$$PWD/../libraries/$$PLATFORM$$CONF/ -llibgeos

INCLUDEPATH += $$PWD/../ilwiscore/core
DEPENDPATH += $$PWD/../ilwiscore/core
INCLUDEPATH += $$PWD/../external/geos
DEPENDPATH += $$PWD/../external/geos
BOOST=../external

INCLUDEPATH +=  ../ilwiscore/core/ilwisobjects \
                ../ilwiscore/core/ilwisobjects/geometry \
                ../ilwiscore/core/util \
                ../ilwiscore/core/ilwisobjects/geometry/geodeticdatum \
                ../ilwiscore/core/ilwisobjects/geometry/projection \
                ../ilwiscore/core/ilwisobjects/geometry/coordinatesystem \
                ../ilwiscore/core/ilwisobjects/geometry/georeference \
                ../ilwiscore/core/ilwisobjects/coverage \
                ../ilwiscore/core/ilwisobjects/table \
                ../ilwiscore/core/ilwisobjects/operation \
                ../ilwiscore/core/catalog \
                ../ilwiscore/core/ilwisobjects/domain \
                $$BOOST


DESTDIR = $$PWD/../libraries/win32debug/extensions/ilwiscoreui
DLLDESTDIR = $$PWD/../output/win32debug/bin/extensions/ilwiscoreui

target.path=$$DLLDESTDIR
qmldir.files=$$PWD/ilwiscoreui/qmldir
qmldir.path=$$DLLDESTDIR
INSTALLS += target qmldir

OTHER_FILES += ilwiscoreui/qmldir \
    ilwiscoreui/qml/controls/CollapsiblePanel.qml \
    ilwiscoreui/qml/controls/CommandLine.qml \
    ilwiscoreui/qml/controls/IlwisComboBox.qml \
    ilwiscoreui/qml/datapanel/CatalogGrid.qml \
    ilwiscoreui/qml/datapanel/CatalogGridDelegate.qml \
    ilwiscoreui/qml/datapanel/CatalogList.qml \
    ilwiscoreui/qml/datapanel/CatalogPanel.qml \
    ilwiscoreui/qml/datapanel/CatalogProperties.qml \
    ilwiscoreui/qml/datapanel/CatalogTable.qml \
    ilwiscoreui/qml/datapanel/CatalogThumbGrid.qml \
    ilwiscoreui/qml/datapanel/CatalogThumbList.qml \
    ilwiscoreui/qml/datapanel/DataPane.qml \
    ilwiscoreui/qml/datapanel/DCatalogThumb.qml \
    ilwiscoreui/qml/workbench/propertyform/DPropertyForm.qml \
    ilwiscoreui/qml/workbench/propertyform/GeneralPropertyPane.qml \
    ilwiscoreui/qml/workbench/ApplicationForm.qml \
    ilwiscoreui/qml/workbench/Bookmarks.qml \
    ilwiscoreui/qml/workbench/CreateCatalogForm.qml \
    ilwiscoreui/qml/workbench/DataSourceFormButtons.qml \
    ilwiscoreui/qml/workbench/DPropertyForm.qml \
    ilwiscoreui/qml/workbench/FileSelectionPanel.qml \
    ilwiscoreui/qml/workbench/FunctionBarHeader.qml \
    ilwiscoreui/qml/workbench/MessagesPane.qml \
    ilwiscoreui/qml/workbench/Navigator.qml \
    ilwiscoreui/qml/workbench/ObjectProperties.qml \
    ilwiscoreui/qml/workbench/OperationCatagoriesList.qml \
    ilwiscoreui/qml/workbench/OperationList.qml \
    ilwiscoreui/qml/workbench/OperationSelection.qml \
    ilwiscoreui/qml/workbench/SelectServiceForm.qml \
    ilwiscoreui/qml/workbench/Tranquilizers.qml \
    ilwiscoreui/qml/workbench/Visualization.qml \
    ilwiscoreui/qml/workbench/VisualizationProperties.qml \
    ilwiscoreui/qml/workbench/WorkBench.qml \
    ilwiscoreui/qml/workbench/WorkBenchButtonBar.qml \
    ilwiscoreui/qml/TabStyle1.qml

# Copy the qmldir file to the same folder as the plugin binary
QMAKE_POST_LINK += $$QMAKE_COPY $$replace($$list($$quote($$PWD/qmldir) $$DLLDESTDIR), /, $$QMAKE_DIR_SEP)

qtcAddDeployment()
