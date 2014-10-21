#include <QString>
#include <QFileInfo>
#include <QUrl>
#include "kernel.h"
#include "connectorinterface.h"
#include "resource.h"
#include "ilwisobject.h"
#include "mastercatalog.h"
#include "resourcemodel.h"

#define tempHardPath "h:/projects/Ilwis4/projects/client/qml/desktop/mobile/images/"
//#define tempHardPath "d:/projects/ilwis/Ilwis4/projects/client/qml/desktop/mobile/images/"

using namespace Ilwis;
//using namespace Desktopclient;

QString ResourceModel::getProperty(const QString &propertyname)
{
    if(_item.hasProperty(propertyname))
        return _item[propertyname].toString();
    return sUNDEF;
}

ResourceModel::ResourceModel()
{

}

ResourceModel::ResourceModel(const Ilwis::Resource& source, QObject *parent) :
    QObject(parent), _imagePath(sUNDEF),_type(itUNKNOWN), _isRoot(false)
{
    resource(source);
}

ResourceModel::~ResourceModel()
{

}

QString ResourceModel::imagePath() const
{
    return _imagePath;
}

quint64 ResourceModel::type() const
{
    return _type;
}

QString ResourceModel::name() const
{
    if ( !_item.isValid()) {
        return _item.name();
    }
    return "";
}

QString ResourceModel::size() const
{
    if ( _item.isValid() && _item.ilwisType() != itCATALOG)
        return  QString::number(_item.size());
    return "";
}

QString ResourceModel::description() const
{
    if ( _item.isValid())
        return _item.description();
    return "";
}

QString ResourceModel::dimensions() const
{
    if ( _item.isValid())
        return _item.dimensions();
    return "";
}

QString ResourceModel::displayName() const
{
    return _displayName;
}

void ResourceModel::setDisplayName(const QString &name)
{
    _displayName = name;
}

QString ResourceModel::url() const
{
    return _item.url().toString();
}

QString ResourceModel::iconPath() const
{
    quint64 tp = _item.ilwisType();
    return iconPath(tp);
}

QString ResourceModel::iconPath(IlwisTypes tp)
{
    if ( tp & itRASTER)
        return "raster20.png";
    else if ( tp == itPOLYGON)
        return "polygon20.png";
    else if ( tp == itLINE)
        return "line20.png";
    else if ( tp == itPOINT)
        return "point20.png";
    else if ( hasType(tp, itFEATURE))
        return "feature20.png";
    else if ( tp & itTABLE)
        return "table20.png";
    else if ( tp & itCOORDSYSTEM)
        return "csy20.png";
    else if ( tp & itGEOREF)
        return "georeference20.png";
    else if ( tp == itCATALOG)
        return "folder.png";
    else if ( tp & itDOMAIN)
        return "domain.png";
    else if ( tp & itREPRESENTATION)
        return "representation.png";
    else if ( hasType(tp,itNUMBER))
        return "numbers20.png";
    else if ( tp & itSTRING)
        return "text20.png";
    else
        return "eye.png";
}

bool ResourceModel::isRoot() const
{
    return _isRoot;
}

QString ResourceModel::id() const
{
    if ( _item.isValid())
        return QString::number(_item.id());
    return sUNDEF;
}

Resource ResourceModel::item() const
{
    return _item;
}


QString ResourceModel::domainName() const {
    QString nme =  propertyName("domain");
    if ( nme != displayName())
        return nme;
    quint64 tp = _item.ilwisType();
    if ( hasType(tp, itCOVERAGE))
        return "self";
    return "";
}

QString ResourceModel::domainType() const {
    return propertyTypeName(itDOMAIN, "domain");
}

QString ResourceModel::coordinateSystemName() const {
    QString nme =  propertyName("coordinatesystem");
    if ( nme != displayName())
        return nme;
    return "";
}

QString ResourceModel::coordinateSystemType() const {
    QString txt = propertyTypeName(itCOORDSYSTEM, "coordinatesystem");
    return txt.left(txt.size() - QString("CoordinateSystem").size());
}

QString ResourceModel::geoReferenceName() const
{
    QString nme = propertyName("georeference");
    if ( nme != displayName())
        return nme;
    return "";
}

QString ResourceModel::geoReferenceType() const
{
    return propertyTypeName(itGEOREF, "georeference");
}



void ResourceModel::resource(const Ilwis::Resource& res)
{
    Resource item = res;
    if ( item.name() == sUNDEF) {
        QString name  = res.url().toString(QUrl::RemoveScheme | QUrl::RemoveQuery | QUrl::RemovePassword | QUrl::StripTrailingSlash);
        name = name.mid(3);
        item.name(name, false);
    }

    _type = item.ilwisType();
    _item = item;

    if ( item.url().toString() == "file://"){
        _displayName = "root";
        _isRoot = true;
    }
    else if ( item.url().scheme() == "file") {
        QFileInfo inf(_item.url().toLocalFile());
        QString path = inf.absolutePath();
        _isRoot = inf.isRoot();
        _displayName = item.name();
        QFileInfo thumbPath = path + "/thumbs/" + _displayName + ".png";
        if ( thumbPath.exists()) {
            _imagePath =  "file:///" +  thumbPath.absoluteFilePath();
        } else {
            if ( item.ilwisType() == itCATALOG) {
                _imagePath = "../images/catalog.png";
            }
            else if ( inf.suffix() == "csy")
                _imagePath = "../images/csy.png";
            else
                _imagePath = "images/remote.png";
        }
    }else
       _displayName = item.name();
}

Ilwis::Resource ResourceModel::resource() const
{
    return _item;
}

Ilwis::Resource& ResourceModel::resourceRef()
{
    return _item;
}

QString ResourceModel::propertyName( const QString& property) const{
    if ( _item.isValid()) {
        bool ok;
        quint64 iddomain =  _item[property].toLongLong(&ok);
        if ( ok) {
            return Ilwis::mastercatalog()->id2Resource(iddomain).name();
        }
    }
    return "";

}

QString  ResourceModel::propertyTypeName(quint64 typ, const QString& propertyName) const {
    if ( _item.isValid()) {
        if (_item.extendedType() & typ) {
            bool ok;
            quint64 idprop =  _item[propertyName].toLongLong(&ok);
            if ( ok) {
                quint64 tp = Ilwis::mastercatalog()->id2Resource(idprop).ilwisType();
                return Ilwis::IlwisObject::type2Name(tp);
            }
        }
    }
    return "";
}

