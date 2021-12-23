%module(directors="1") urcl__rtde;
//Wichtig: Modul muss anders heissen, als die Namespaces! Sonst gibt es den Namen als Klasse (wegen dem Modul) und als Namespace. Das gibt Probleme.

%include "_common.i"

// Own generic .i files
%include "primitive_type_ptr.i"
%include "std_chrono.i"
%include "std_unique_ptr.i"

//Other Modules
%import "urcl.comm.i"
//%import "urcl.comm.INotifier.i" //Direct submodule of urcl.comm
%import "urcl.control.i"
%import "urcl.i"
//%import "urcl.log.i" //Direct submodule of urcl
%import "urcl.primary.i"
%import "urcl.queue.i"
//%import "urcl.rtde.data_package.i"
//%import "rtde.i"
%import "urcl.ur.i"
//->Wenn die Module gegenseitige Abhängigkeiten haben, dann diese nur an der entsprechenden Stelle rein machen. Nicht hier.

//%primitive_type_ptr(size_t, SizeTContainer)

%{
//Includes the header files in the wrapper code
#include "rtde/package_header.h"
#include "rtde/request_protocol_version.h"
#include "rtde/control_package_setup_inputs.h"
#include "rtde/rtde_package.h"
#include "rtde/control_package_pause.h"
#include "rtde/get_urcontrol_version.h"
#include "rtde/text_message.h"
#include "rtde/rtde_client.h"
#include "rtde/rtde_parser.h"
#include "rtde/control_package_start.h"
#include "rtde/control_package_setup_outputs.h"
#include "rtde/rtde_writer.h"

using namespace urcl; //For UrException
%}

%ignore UR_RTDE_PORT;
%ignore PIPELINE_NAME;

%ignore urcl::rtde_interface::MAX_RTDE_PROTOCOL_VERSION;
%ignore urcl::rtde_interface::MAX_REQUEST_RETRIES;

%ignore urcl::rtde_interface::UrRtdeRobotStatusBits;
%ignore urcl::rtde_interface::UrRtdeSafetyStatusBits;


// Begin Includes
///////////////////////////
//%include "rtde/package_header.h"

//%template(RtdePackageHeaderURPackage) urcl::comm::URPackage<urcl::rtde_interface::PackageHeader>;
//%include "rtde/rtde_package.h"
//%template (RTDEPackageURStream) urcl::comm::URStream<urcl::rtde_interface::RTDEPackage>;

//%include "rtde/request_protocol_version.h"
//%include "rtde/control_package_setup_inputs.h"
//%include "rtde/control_package_pause.h"
//%include "rtde/get_urcontrol_version.h"
//%include "rtde/text_message.h"

//%include "rtde/rtde_writer.h"

%ignore "urcl::rtde_interface::RTDEClient::getWriter";

%unique_ptr(urcl::rtde_interface::DataPackage); //getDataPackage

//Used to catch all Exceptions thrown within rtde_client.h
//exeptions.h: All urcl Excpetions inherit from std::runtime_error which itself inherits from std::exception
%exception {
    try {
        $action
    }
    catch (const std::exception& e) {
        SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, e.what());
        return $null;
    }
}

//%catches(UrException) urcl::rtde_interface::RTDEClient::init;
//%catches(UrException) urcl::rtde_interface::RTDEClient::negotiateProtocolVersion;

%include "rtde/rtde_client.h"

//%include "rtde/control_package_start.h"
//%include "rtde/control_package_setup_outputs.h"
///////////////////////////
// End Includes

//"Submodules"
%import "urcl.rtde.data_package.i"

