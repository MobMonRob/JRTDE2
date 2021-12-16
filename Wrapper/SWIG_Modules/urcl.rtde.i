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
//comm
%import "urcl.control.i"
//primary
//ur
//->Wenn die Module gegenseitige Abhängigkeiten haben, dann diese nur an der entsprechenden Stelle rein machen. Nicht hier.

#define __WORDSIZE 64
%import "/usr/include/x86_64-linux-gnu/bits/typesizes.h";
%import "/usr/include/x86_64-linux-gnu/bits/time64.h";
%import "/usr/include/x86_64-linux-gnu/bits/types.h";
%include "/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h";
#undef __WORDSIZE

%primitive_type_ptr(size_t, SizeTContainer)

%template (VectorString) std::vector<std::string>;

%{
//Includes the header files in the wrapper code
#include "exceptions.h"
#include "ur/datatypes.h"
#include "ur/version_information.h"
#include "ur/tool_communication.h"
#include "ur/calibration_checker.h"
#include "ur/dashboard_client.h"
#include "ur/ur_driver.h"
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
#include "comm/producer.h"
#include "comm/package.h"
#include "comm/pipeline.h"
#include "comm/parser.h"
#include "comm/package_serializer.h"
#include "comm/stream.h"
#include "comm/tcp_server.h"
#include "comm/tcp_socket.h"
#include "comm/control_mode.h"
#include "comm/shell_consumer.h"
#include "comm/bin_parser.h"
#include "primary/package_header.h"
#include "primary/primary_package.h"
#include "primary/robot_state.h"
#include "primary/robot_state/kinematics_info.h"
#include "primary/robot_message.h"
#include "primary/abstract_primary_consumer.h"
#include "primary/robot_message/version_message.h"
#include "primary/primary_parser.h"

// Dangerous!
using namespace urcl;
using namespace urcl::primary_interface;
%}


/*
 * Deactivated serialization.
 * Too low-levely.
 * If needed: turn back on.
*/
///////////////////////////
%ignore generateSerializedRequest;
%ignore serializeHeader;
//parseWith benötigt, damit DataPackage nicht abstrakt ist in Java
//%ignore parseWith;
%ignore serializePackage;
//%warnfilter(403);
///////////////////////////
//%include "various.i"
//%apply uint8_t* NIOBUFFER { unsigned char * buf };
//%apply uint8_t* NIOBUFFER { unsigned char * buffer };
//The serialization functions return the length of the new buffer.
//This seems to be incompatbile with java.nio.buffer
//because there might be boundary checks with outdated
//capacity values. And there is no way to change them.

//Inspiration:
//https://github.com/swig/swig/blob/v4.0.1/Lib/java/various.i
//->Lösung wäre: Eigene C++ Klasse bauen, die das berücksichtigt und keine Boundary Checks macht.
//->Es sollte eine Möglichkeit geben, den Inhalt dann auf einen Schlag in ein Java Array oder ein Java NIO zu kovertieren. In beide Richtungen.
//->Keine Möglichkeit geben, Elemente raus zu holen oder rein zu füllen.
//Es muss die Möglickeit geben, den Inhalt in Java zu allozieren.
//Aber auch, dass der Inhalt in C++ alloziert wird und die neue Größe dann später zugewiesen wird.
//->Da muss man dann höllisch aufpassen.

//%import "comm/parser.h"
//%import "comm/package_serializer.h"

%ignore urcl::comm::BinParser::parse;
%ignore urcl::comm::BinParser::parseRemainder;
%ignore urcl::comm::BinParser::rawData;
%include "comm/bin_parser.h"

//%template(PrimaryPackageParser) urcl::comm::Parser<urcl::primary_interface::PrimaryPackage>;
//%import "primary/primary_parser.h"

//%template(RTDEPackageParser) urcl::comm::Parser<urcl::rtde_interface::RTDEPackage>;
//%std_vector_unique_ptr(RTDEPackageVector, urcl::rtde_interface::RTDEPackage)
//%include "rtde/rtde_parser.h"
///////////////////////////
// End Serialization


// Begin Imports
///////////////////////////
%import "comm/producer.h"
%import "comm/package.h"
%import "comm/tcp_server.h"
%import "comm/stream.h"
%import "comm/control_mode.h"
%import "comm/shell_consumer.h"

%import "types.h"

%import "primary/package_header.h"

//%ignore urcl::primary_interface::PrimaryPackage::consumeWith;
//%shared_ptr(urcl::comm::URPackage<urcl::primary_interface::PackageHeader>)
//%shared_ptr(urcl::primary_interface::PrimaryPackage)
//%shared_ptr(urcl::primary_interface::RobotState
//%shared_ptr(urcl::primary_interface::KinematicsInfo)
//%shared_ptr(urcl::primary_interface::RobotMessage)
//%shared_ptr(urcl::primary_interface::VersionMessage)
//%template(PackageHeaderURPackage) urcl::comm::URPackage<urcl::primary_interface::PackageHeader>;
//%import "primary/primary_package.h"

//%import "primary/robot_state.h"
//%import "primary/robot_state/kinematics_info.h"
//%import "primary/robot_message.h"

//%template(PrimaryPackageConsumer) urcl::comm::IConsumer<urcl::primary_interface::PrimaryPackage>;
//%import "primary/abstract_primary_consumer.h"

//%interface_impl(urcl::primary_interface::AbstractPrimaryConsumer);
//%import "primary/robot_message/version_message.h"

%import "ur/datatypes.h"

//%import "ur/tool_communication.h"
//%import "ur/calibration_checker.h"
//%import "ur/dashboard_client.h"

//%warnfilter(302) urcl::UrDriver;
//%import "ur/ur_driver.h"

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
%include "comm/tcp_socket.h"

/*
 * Usage:
 * Inherit from INotifierSwigImpl to use Director Functionality.
*/
//The Problem here is that SWIG uses the Base Destructor to delete the
//INotifier Director and the Base Destructor is not virtual.
//Would not be a Problem if SWIG would just use the
//INotifier Director Destructor.
//%feature("director") urcl::comm::INotifier;

//SWIG Bug: SWIG uses the Base Destructor to delete the INotifier Director
//RTDE: Not a Bug if it ist not intended to be used polymorphicallly.
// - But against C++ recommendations that virtual methods imply virtual destructor.

//Just don't use INotifierSWIGImpl.
//But instead: Inherit from Notifier.java.
//And use INotifier.java to point to it.
%interface_impl(urcl::comm::INotifier)
%include "comm/pipeline.h"
%feature("director") urcl::comm::Notifier;
%inline {
    namespace urcl::comm {
        class Notifier : public urcl::comm::INotifier {
            public:
            virtual ~Notifier() {
            }
        };
    }
}

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

