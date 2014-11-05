#include "ilwisobjectmodel.h"
#include "coverage.h"
#include "featurecoverage.h"
#include "feature.h"
#include "table.h"
#include "raster.h"


using namespace Ilwis;

IlwisObjectModel::IlwisObjectModel()
{
}

IlwisObjectModel::IlwisObjectModel(const Ilwis::Resource &source, QObject *parent) : ResourceModel(source, parent)
{
    _ilwisobject.prepare(resource());
}

QString IlwisObjectModel::creationDate() const
{
    if ( _ilwisobject.isValid()){
        Time creationTime = _ilwisobject->createTime();
        if ( creationTime.isValid())
            return creationTime.toString();
    }

    return "";
}

QString IlwisObjectModel::modifiedDate() const
{
    if ( _ilwisobject.isValid()){
        Time modifiedTime = _ilwisobject->modifiedTime();
        if ( modifiedTime.isValid())
            return modifiedTime.toString();
    }

    return "";
}

bool IlwisObjectModel::readonly() const
{
    if ( _ilwisobject.isValid()){
        return _ilwisobject->isReadOnly();
    }
    return true;
}

void IlwisObjectModel::readonly(bool yesno) const
{
    if ( _ilwisobject.isValid()){
        _ilwisobject->readOnly(yesno);
    }
}

QString IlwisObjectModel::description() const
{
    if ( _ilwisobject.isValid()){
        QString desc = _ilwisobject->description();
        if ( desc != sUNDEF)
            return desc;
    }
    return "";
}

QString IlwisObjectModel::externalFormat() const
{
    if ( _ilwisobject.isValid()){
        return _ilwisobject->externalFormat();
    }
    return "";
}

bool IlwisObjectModel::externalReadOnly() const
{
   if ( _ilwisobject.isValid()){
       return _ilwisobject->outputConnectionReadonly();
   }
   return true;
}

void IlwisObjectModel::description(const QString &desc) const
{
    if ( _ilwisobject.isValid())
        _ilwisobject->setDescription(desc);
}

QString IlwisObjectModel::valuetype() const
{
    if ( !_ilwisobject.isValid())
        return "";

    IlwisTypes objectype = _ilwisobject->ilwisType();
    IlwisTypes valueType = itUNKNOWN;
    if ( hasType( objectype, itCOVERAGE|itDOMAIN)){
        if ( objectype == itRASTER){
            IRasterCoverage raster = _ilwisobject.as<RasterCoverage>();
            valueType = raster->datadef().domain()->valueType();
        } else if ( hasType( objectype , itFEATURE)){
            IFeatureCoverage features = _ilwisobject.as<FeatureCoverage>();
            ColumnDefinition coldef = features->attributeDefinitions().columndefinition(COVERAGEKEYCOLUMN);
            if ( coldef.isValid()){
                valueType = coldef.datadef().domain()->valueType();
            }

        } else if ( hasType( objectype , itDOMAIN)){
            IDomain dom = _ilwisobject.as<Domain>();
            valueType = dom->valueType();

        }
    }
    QString typeName =  TypeHelper::type2HumanReadable(valueType);

    return typeName == sUNDEF ? "" : typeName;
}

QString IlwisObjectModel::getProperty(const QString &propertyname)
{
    QString property = ResourceModel::getProperty(propertyname);
    if ( property != sUNDEF)
        return property;
    return sUNDEF;
}

bool IlwisObjectModel::isValid() const
{
    return _ilwisobject.isValid();
}
