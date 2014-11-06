#ifndef ILWISOBJECTMODEL_H
#define ILWISOBJECTMODEL_H

#include "kernel.h"
#include "ilwisdata.h"
#include "resourcemodel.h"

class IlwisObjectModel : public ResourceModel
{
    Q_OBJECT
    Q_PROPERTY(QString isValid READ isValid CONSTANT)
    Q_PROPERTY(QString creationDate READ creationDate CONSTANT)
    Q_PROPERTY(QString modifiedDate READ modifiedDate CONSTANT)
    Q_PROPERTY(bool isReadonly READ readonly CONSTANT)
    Q_PROPERTY(QString externalFormat READ externalFormat CONSTANT)
    Q_PROPERTY(bool externalReadOnly READ externalReadOnly CONSTANT)
    Q_PROPERTY(QString valuetype READ valuetype CONSTANT)
    Q_PROPERTY(QString rangeDefinition READ rangeDefinition CONSTANT)


public:
    IlwisObjectModel();
    explicit IlwisObjectModel(const Ilwis::Resource &source, QObject *parent = 0);

    QString creationDate() const;
    QString modifiedDate() const;
    bool readonly() const;
    void readonly(bool yesno) const;
    QString description() const;
    QString externalFormat() const;
    bool externalReadOnly() const;
    void description(const QString& desc) const;
    QString valuetype() const;
    QString rangeDefinition();

    Q_INVOKABLE QString virtual getProperty(const QString& propertyname);

    bool isValid() const;

private:
    Ilwis::IIlwisObject _ilwisobject;
};

#endif // ILWISOBJECTMODEL_H
