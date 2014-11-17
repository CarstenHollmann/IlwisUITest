#ifndef MODELERMODEL_H
#define MODELERMODEL_H

#include <QQmlListProperty>
#include <QColor>
#include "kernel.h"

#include <QObject>

class WorkflowModel : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QString description READ description CONSTANT)

public:
    WorkflowModel();
    explicit WorkflowModel(const QString &name, const QString &desccription, QObject *parent);
    QString name() const;
    QString description() const;

private:
    QString _name;
    QString _description;
};

typedef QQmlListProperty<WorkflowModel> QMLModellerList;

class ModellerModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QMLModellerList workflows READ workflows NOTIFY workflowChanged)

public:
    explicit ModellerModel(QObject *parent = 0);

    QMLModellerList workflows();
    int count();
    WorkflowModel* get(int index);

signals:
    void workflowChanged();

public slots:
    void addWorkflow(const QString &name, const QString &desccription);

private:
   QList<WorkflowModel *> _models;

};

Q_DECLARE_METATYPE(QMLModellerList)

#endif // MODELERMODEL_H
