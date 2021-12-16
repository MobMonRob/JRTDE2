%module(directors="1") urcl__rtde;
//Wichtig: Modul muss anders heissen, als die Namespaces! Sonst gibt es den Namen als Klasse (wegen dem Modul) und als Namespace. Das gibt Probleme.

%include "_common.i"

// Own generic .i files
%include "primitive_type_ptr.i"
%include "std_chrono.i"
%include "std_unique_ptr.i"
%include "std_vector_unique_ptr.i"

// SWIG lib .i fles
%include "stdint.i"
%include "std_string.i";
%include "arrays_java.i";
%include "std_common.i"
%include "java.swg"
%include "std_array.i"
%include <swiginterface.i>
//Make get_Cptr public
//#define SWIG_SHARED_PTR_TYPEMAPS(CONST, TYPE...) SWIG_SHARED_PTR_TYPEMAPS_IMPLEMENTATION(public, public, CONST, TYPE)
%include <std_shared_ptr.i>
//Important: http://www.swig.org/Doc4.0/Library.html#Library_std_shared_ptr

//Other Modules
%import "urcl.comm.i"
%import "urcl.control.i"
%import "urcl.primary.i"
%import "urcl.ur.i"
%import "urcl.queue.i"
//->Wenn die Module gegenseitige Abhängigkeiten haben, dann diese nur an der entsprechenden Stelle rein machen. Nicht hier.

//Wo gehört das hier dazu?
#define __WORDSIZE 64
%import "/usr/include/x86_64-linux-gnu/bits/typesizes.h";
%import "/usr/include/x86_64-linux-gnu/bits/time64.h";
%import "/usr/include/x86_64-linux-gnu/bits/types.h";
%include "/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h";
#undef __WORDSIZE

//Wo gehört das hier dazu?
%primitive_type_ptr(size_t, SizeTContainer)

//Wo gehört das hier dazu?
%template (VectorString) std::vector<std::string>;

%{
//Includes the header files in the wrapper code
#include "exceptions.h"
#include "queue/readerwriterqueue.h"
#include "queue/atomicops.h"
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
#include "types.h"

// Dangerous!
using namespace urcl;
using namespace urcl::primary_interface;
%}


// Begin Imports
///////////////////////////
%import "types.h"

%define AE_GCC
%define AE_ARCH_X64
%import "queue/readerwriterqueue.h"
%import "queue/atomicops.h"
%enddef
%enddef
///////////////////////////
// End Imports


// Begin Includes
///////////////////////////
//Can't wrap 'operator <<' unless renamed to a valid identifier.
%warnfilter(503) urcl::VersionInformation;
%include "ur/version_information.h"


//%warnfilter(401) urcl;
//%warnfilter(516) urcl::UrException;
//%include "exceptions.h"

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

%unique_ptr(urcl::rtde_interface::DataPackage)
// Es fehlen noch viele %catches mehr überall im Code!
%catches(UrException) urcl::rtde_interface::RTDEClient::init;
%catches(UrException) urcl::rtde_interface::RTDEClient::negotiateProtocolVersion;
%include "rtde/rtde_client.h"

%include "rtde/control_package_start.h"
%include "rtde/control_package_setup_outputs.h"
///////////////////////////
// End Includes


%import "urcl.rtde.data_package.i"
%import "urcl.log.i"

