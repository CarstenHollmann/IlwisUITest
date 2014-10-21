#include "kernel.h"
#include "usermessagehandler.h"

using namespace Ilwis;

UserMessageHandler::UserMessageHandler(QObject *parent) :
    QObject(parent)
{
    QList<IssueObject> issues;
    kernel()->issues()->copy(issues);
    for(auto issue : issues)
        addMessage(issue);
}

QMLMessageList UserMessageHandler::messages()
{
    return  QQmlListProperty<MessageModel>(this, _messages);
}

void UserMessageHandler::addMessage(const IssueObject& issue)
{
    _messages.insert(0, new MessageModel(issue, this));
    emit messageChanged();
    emit messageIconChanged();
}

QString UserMessageHandler::messageIcon() const{
    if ( _messages.size() > 0){
        return _messages.first()->messageIcon();
    }
    return "message40.png";
}

//---------------------------------------------------
MessageModel::MessageModel()
{

}

MessageModel::MessageModel(const IssueObject &issue, QObject *parent) : QObject(parent), _message(issue)
{

}

QString MessageModel::time() const
{
    return  Ilwis::Time(_message.time()).toString();
}

QString MessageModel::shorttime() const
{
    return Ilwis::Time(_message.time()).toString(false, itTIME);
}

QString MessageModel::type() const
{
    switch(_message.type()){
    case IssueObject::itWarning:
        return "warning";
    case IssueObject::itError:
        return "error";
    case IssueObject::itCritical:
        return "critical error";
    case IssueObject::itMessage:
        return "notification";
    case IssueObject::itDebug:
        return "trace";
    default:
        return "";
    }
}

QString MessageModel::message() const
{
    return _message.message();
}

quint64 MessageModel::id()
{
    return _message.id();
}

QColor MessageModel::color() const
{
    switch(_message.type()){
    case IssueObject::itWarning:
        return QColor("orange");
    case IssueObject::itError:
        return QColor("red");
    case IssueObject::itCritical:
        return QColor("purple");
    case IssueObject::itMessage:
        return "green";
    case IssueObject::itDebug:
        return "blue";
    default:
        return "";
    }
}

QString MessageModel::messageIcon() const
{
    switch(_message.type()){
    case IssueObject::itWarning:
        return "messageorange40.png";
    case IssueObject::itError:
        return "messagered40.png";
    case IssueObject::itCritical:
        return "messagepurple40.png";
    default:
        return "message40.png";

    }
}
