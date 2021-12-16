%module urcl__;

// Own generic .i files
%include "_common.i"


// SWIG lib .i fles


%{
#include "exceptions.h"

//Needed in other modules when accessed
using namespace urcl; //For UrException

#include "types.h"
%}

%import "types.h"

//%warnfilter(401) urcl;
//%warnfilter(516) urcl::UrException;
//%include "exceptions.h"

//"Submodules"
%import "urcl.log.i"

