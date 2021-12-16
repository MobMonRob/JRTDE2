%module(directors="1") urcl__rtde;
//Wichtig: Modul muss anders heissen, als die Namespaces! Sonst gibt es den Namen als Klasse (wegen dem Modul) und als Namespace. Das gibt Probleme.

%include "_common.i"

// Own generic .i files
%include "primitive_type_ptr.i"
%include "std_chrono.i"
%include "std_unique_ptr.i"

//Other Modules
%import "urcl.comm.i"
%import "urcl.control.i"
%import "urcl.primary.i"
%import "urcl.ur.i"
%import "urcl.queue.i"
//->Wenn die Module gegenseitige Abhängigkeiten haben, dann diese nur an der entsprechenden Stelle rein machen. Nicht hier.

%primitive_type_ptr(size_t, SizeTContainer)

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


// Begin Includes
///////////////////////////
%include "rtde/package_header.h"

%template(RtdePackageHeaderURPackage) urcl::comm::URPackage<urcl::rtde_interface::PackageHeader>;
%include "rtde/rtde_package.h"
%template (RTDEPackageURStream) urcl::comm::URStream<urcl::rtde_interface::RTDEPackage>;

%include "rtde/request_protocol_version.h"
%include "rtde/control_package_setup_inputs.h"
%include "rtde/control_package_pause.h"
%include "rtde/get_urcontrol_version.h"
%include "rtde/text_message.h"

%include "rtde/rtde_writer.h"

%unique_ptr(urcl::rtde_interface::DataPackage);
// Es fehlen noch viele %catches mehr überall im Code!
%catches(UrException) urcl::rtde_interface::RTDEClient::init;
%catches(UrException) urcl::rtde_interface::RTDEClient::negotiateProtocolVersion;
%include "rtde/rtde_client.h"

%include "rtde/control_package_start.h"
%include "rtde/control_package_setup_outputs.h"
///////////////////////////
// End Includes

//"Submodules"
%import "urcl.rtde.data_package.i"

