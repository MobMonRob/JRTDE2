%module(directors="1") urcl__log;

%include "_common.i"

%ignore urcl::registerLogHandler(std::unique_ptr<LogHandler> loghandler);
%feature("director") urcl::LogHandler;
%include "log.h"

%{
#include "log.h"

namespace urcl
{
class LockHandlerOwnershipAdapter : public urcl::LogHandler {
public:
LockHandlerOwnershipAdapter(urcl::LogHandler* logHandler) : logHandler_ptr(logHandler) {
}

void log(const char* file, int line, LogLevel loglevel, const char* log) override {
    this->logHandler_ptr->log(file, line, loglevel, log);
}

private:
urcl::LogHandler* logHandler_ptr;

};
}
%}

%inline %{
    #include "log.h"

    namespace urcl {

    /*!
    * \brief Register a new LogHandler object, for handling log messages.
    *
    * \param loghandler Pointer to the new object
    */
    void registerTheLogHandler(urcl::LogHandler* loghandler) {
        registerLogHandler(std::make_unique<LockHandlerOwnershipAdapter>(loghandler));
    }
    }
%}

//Not needed
//%include "default_log_handler.h"

