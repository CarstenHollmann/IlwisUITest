#ifndef CATALOGMODEL_H
#define CATALOGMODEL_H

#include <QObject>
#include <QFileInfo>
#include <QQmlListProperty>
#include "resourcemodel.h"
#include "catalogview.h"

namespace Ilwis {

}
//namespace Desktopclient {


class CatalogModel : public ResourceModel
{
    Q_OBJECT
public:
    Q_PROPERTY(QQmlListProperty<ResourceModel> resources READ resources CONSTANT)
    Q_PROPERTY(bool initNode READ initNode CONSTANT)
    Q_PROPERTY(int level READ level CONSTANT)
    Q_PROPERTY(int isScanned READ isScanned CONSTANT)

    CatalogModel() ;
    explicit CatalogModel(const Ilwis::CatalogView &view, int lvl, QObject *parent = 0);
    bool isScanned() const;
    bool initNode() const;
    int level() const;
    QQmlListProperty<ResourceModel> resources();
    void filterChanged(const QString &objectType, bool state);
protected:
    Ilwis::CatalogView _view;
    void newview(const Ilwis::CatalogView &view);
    void gatherItems();
   QList<ResourceModel *> _currentItems;

private:
    //bool _hasChilderen;
    bool _isScanned;
    bool _initNode;
    int _level;
    std::map<QString, bool> _filterState;
    bool _refresh = false;


};

template <typename T>
struct CatLess // public std::binary_function<bool, const T*, const T*>
{
  bool operator()(QObject* a, QObject* b) const
  {
      if ( a == nullptr || b == nullptr)
          return false;

      return static_cast<T *>(a)->displayName().toLower() < static_cast<T *>(b)->displayName().toLower();
  }
};
//}
//}

#endif // CATALOGMODEL_H
