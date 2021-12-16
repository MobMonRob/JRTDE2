%module urcl__ur;

// Own generic .i files
%include "_common.i"


// SWIG lib .i fles
%include <stdint.i>


%{
#include <sstream>
#include "ur/datatypes.h"

#include "ur/version_information.h"
#include "ur/tool_communication.h"
#include "ur/calibration_checker.h"
#include "ur/dashboard_client.h"
#include "ur/ur_driver.h"
%}

%import "ur/datatypes.h"

//%import "ur/tool_communication.h"
//%import "ur/calibration_checker.h"
//%import "ur/dashboard_client.h"

//%warnfilter(302) urcl::UrDriver;
//%import "ur/ur_driver.h"

//Can't wrap 'operator <<' unless renamed to a valid identifier.
%warnfilter(503) urcl::VersionInformation;
%include "ur/version_information.h"

