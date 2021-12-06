%module(directors="1") urclSwig;
//Wichtig: Modul muss anders heissen, als die Namespaces! Sonst gibt es den Namen als Klasse (wegen dem Modul) und als Namespace. Das gibt Probleme.

%include "_common.i"

#define __WORDSIZE 64
%import "/usr/include/x86_64-linux-gnu/bits/typesizes.h";
%import "/usr/include/x86_64-linux-gnu/bits/time64.h";
%import "/usr/include/x86_64-linux-gnu/bits/types.h";
%include "/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h";
#undef __WORDSIZE

%primitive_type_ptr(size_t, SizeTContainer)

%{
//Includes the header files in the wrapper code
#include "ur_client_library/control/reverse_interface.h"
#include "ur_client_library/control/script_sender.h"
#include "ur_client_library/control/trajectory_point_interface.h"
#include "ur_client_library/exceptions.h"
#include "ur_client_library/ur/datatypes.h"
#include "ur_client_library/ur/version_information.h"
#include "ur_client_library/ur/tool_communication.h"
#include "ur_client_library/ur/calibration_checker.h"
#include "ur_client_library/ur/dashboard_client.h"
#include "ur_client_library/ur/ur_driver.h"
#include "ur_client_library/queue/readerwriterqueue.h"
#include "ur_client_library/queue/atomicops.h"
#include "ur_client_library/rtde/package_header.h"
#include "ur_client_library/rtde/request_protocol_version.h"
#include "ur_client_library/rtde/control_package_setup_inputs.h"
#include "ur_client_library/rtde/rtde_package.h"
#include "ur_client_library/rtde/control_package_pause.h"
#include "ur_client_library/rtde/get_urcontrol_version.h"
#include "ur_client_library/rtde/text_message.h"
#include "ur_client_library/rtde/rtde_client.h"
#include "ur_client_library/rtde/rtde_parser.h"
#include "ur_client_library/rtde/control_package_start.h"
#include "ur_client_library/rtde/control_package_setup_outputs.h"
#include "ur_client_library/rtde/rtde_writer.h"
#include "ur_client_library/default_log_handler.h"
#include "ur_client_library/log.h"
#include "ur_client_library/types.h"
#include "ur_client_library/comm/producer.h"
#include "ur_client_library/comm/package.h"
#include "ur_client_library/comm/pipeline.h"
#include "ur_client_library/comm/parser.h"
#include "ur_client_library/comm/package_serializer.h"
#include "ur_client_library/comm/stream.h"
#include "ur_client_library/comm/tcp_server.h"
#include "ur_client_library/comm/tcp_socket.h"
#include "ur_client_library/comm/control_mode.h"
#include "ur_client_library/comm/shell_consumer.h"
#include "ur_client_library/comm/bin_parser.h"
#include "ur_client_library/primary/package_header.h"
#include "ur_client_library/primary/primary_package.h"
#include "ur_client_library/primary/robot_state.h"
#include "ur_client_library/primary/robot_state/kinematics_info.h"
#include "ur_client_library/primary/robot_message.h"
#include "ur_client_library/primary/abstract_primary_consumer.h"
#include "ur_client_library/primary/robot_message/version_message.h"
#include "ur_client_library/primary/primary_parser.h"

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

//%import "ur_client_library/comm/parser.h"
//%import "ur_client_library/comm/package_serializer.h"

%ignore urcl::comm::BinParser::parse;
%ignore urcl::comm::BinParser::parseRemainder;
%ignore urcl::comm::BinParser::rawData;
%include "ur_client_library/comm/bin_parser.h"

//%template(PrimaryPackageParser) urcl::comm::Parser<urcl::primary_interface::PrimaryPackage>;
//%import "ur_client_library/primary/primary_parser.h"

//%template(RTDEPackageParser) urcl::comm::Parser<urcl::rtde_interface::RTDEPackage>;
//%std_vector_unique_ptr(RTDEPackageVector, urcl::rtde_interface::RTDEPackage)
//%include "ur_client_library/rtde/rtde_parser.h"
///////////////////////////
// End Serialization


// Begin Imports
///////////////////////////
%import "ur_client_library/comm/producer.h"
%import "ur_client_library/comm/package.h"
%import "ur_client_library/comm/tcp_server.h"
%import "ur_client_library/comm/stream.h"
%import "ur_client_library/comm/control_mode.h"
%import "ur_client_library/comm/shell_consumer.h"

%import "ur_client_library/control/reverse_interface.h"
%import "ur_client_library/control/script_sender.h"
%import "ur_client_library/control/trajectory_point_interface.h"

%import "ur_client_library/types.h"

%import "ur_client_library/primary/package_header.h"

//%ignore urcl::primary_interface::PrimaryPackage::consumeWith;
//%shared_ptr(urcl::comm::URPackage<urcl::primary_interface::PackageHeader>)
//%shared_ptr(urcl::primary_interface::PrimaryPackage)
//%shared_ptr(urcl::primary_interface::RobotState
//%shared_ptr(urcl::primary_interface::KinematicsInfo)
//%shared_ptr(urcl::primary_interface::RobotMessage)
//%shared_ptr(urcl::primary_interface::VersionMessage)
//%template(PackageHeaderURPackage) urcl::comm::URPackage<urcl::primary_interface::PackageHeader>;
//%import "ur_client_library/primary/primary_package.h"

//%import "ur_client_library/primary/robot_state.h"
//%import "ur_client_library/primary/robot_state/kinematics_info.h"
//%import "ur_client_library/primary/robot_message.h"

//%template(PrimaryPackageConsumer) urcl::comm::IConsumer<urcl::primary_interface::PrimaryPackage>;
//%import "ur_client_library/primary/abstract_primary_consumer.h"

//%interface_impl(urcl::primary_interface::AbstractPrimaryConsumer);
//%import "ur_client_library/primary/robot_message/version_message.h"

%import "ur_client_library/ur/datatypes.h"

//%import "ur_client_library/ur/tool_communication.h"
//%import "ur_client_library/ur/calibration_checker.h"
//%import "ur_client_library/ur/dashboard_client.h"

//%warnfilter(302) urcl::UrDriver;
//%import "ur_client_library/ur/ur_driver.h"

%define AE_GCC
%define AE_ARCH_X64
%import "ur_client_library/queue/readerwriterqueue.h"
%import "ur_client_library/queue/atomicops.h"
%enddef
%enddef
///////////////////////////
// End Imports


// Begin Includes
///////////////////////////
%include "ur_client_library/comm/tcp_socket.h"

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
%include "ur_client_library/comm/pipeline.h"
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
%include "ur_client_library/ur/version_information.h"


//%warnfilter(401) urcl;
//%warnfilter(516) urcl::UrException;
//%include "ur_client_library/exceptions.h"

%include "ur_client_library/rtde/package_header.h"

%template(RtdePackageHeaderURPackage) urcl::comm::URPackage<urcl::rtde_interface::PackageHeader>;
%include "ur_client_library/rtde/rtde_package.h"
%template (RTDEPackageURStream) urcl::comm::URStream<urcl::rtde_interface::RTDEPackage>;

%include "ur_client_library/rtde/request_protocol_version.h"
%include "ur_client_library/rtde/control_package_setup_inputs.h"
%include "ur_client_library/rtde/control_package_pause.h"
%include "ur_client_library/rtde/get_urcontrol_version.h"
%include "ur_client_library/rtde/text_message.h"

%include "ur_client_library/rtde/rtde_writer.h"

%unique_ptr(urcl::rtde_interface::DataPackage)
// Es fehlen noch viele %catches mehr überall im Code!
%catches(UrException) urcl::rtde_interface::RTDEClient::init;
%catches(UrException) urcl::rtde_interface::RTDEClient::negotiateProtocolVersion;
%include "ur_client_library/rtde/rtde_client.h"

%include "ur_client_library/rtde/control_package_start.h"
%include "ur_client_library/rtde/control_package_setup_outputs.h"
///////////////////////////
// End Includes


%import "urcl_data_package.i"

