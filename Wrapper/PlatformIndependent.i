%module urclSwig;
//Wichtig: Modul muss anders heissen, als die Namespaces! Sonst gibt es den Namen als Klasse (wegen dem Modul) und als Namespace. Das gibt Probleme.

%feature("nspace");
//Muss unbedingt vor den Template Instanzierungen stehen, damit die zugreifbar bleiben.
//Refer to end of section of http://www.swig.org/Doc4.0/Java.html#Java_code_typemaps
//Nur notwendig, wenn nspace Feature aktiv
SWIG_JAVABODY_PROXY(public, public, SWIGTYPE)
SWIG_JAVABODY_TYPEWRAPPER(public, public, public, SWIGTYPE)
SWIG_JAVABODY_METHODS(public, public, SWIGTYPE)

//Make get_Cptr public
//#define SWIG_SHARED_PTR_TYPEMAPS(CONST, TYPE...) SWIG_SHARED_PTR_TYPEMAPS_IMPLEMENTATION(public, public, CONST, TYPE)
%import "std_shared_ptr.i";
//Important: http://www.swig.org/Doc4.0/Library.html#Library_std_shared_ptr
//%shared_ptr(std::vector<unsigned char>)

%include "stdint.i"

//Maybe above nspace Feature?
%include "std_string.i";
%include "arrays_java.i";
%include "std_vector.i"

//Interface cannot be instantiated
%include <swiginterface.i>

//Fixes [...]SwigJNI class to invoke NativeLibLoader
%pragma(java) jniclassimports=%{
import de.dhbw.rahmlab.vicon.datastream.nativelib.NativeLibLoader;
%}

%pragma(java) jniclasscode=%{
static {
	NativeLibLoader.load();
}
%}

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
#include "ur_client_library/rtde/data_package.h"
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

//Parse the header files to generate wrappers
%import "ur_client_library/comm/producer.h"
%import "ur_client_library/comm/package.h"
%import "ur_client_library/comm/pipeline.h"
%import "ur_client_library/comm/parser.h"
%import "ur_client_library/comm/package_serializer.h"
%import "ur_client_library/comm/stream.h"
%import "ur_client_library/comm/tcp_server.h"
%import "ur_client_library/comm/tcp_socket.h"
%import "ur_client_library/comm/control_mode.h"
%import "ur_client_library/comm/shell_consumer.h"
%import "ur_client_library/comm/bin_parser.h"

%interface_impl(urcl::control::ReverseInterface);
%import "ur_client_library/control/reverse_interface.h"

%import "ur_client_library/control/script_sender.h"

%interface_impl(urcl::control::trajectory_point_interface);
%import "ur_client_library/control/trajectory_point_interface.h"

//%import "ur_client_library/exceptions.h"

%import "ur_client_library/log.h"
%import "ur_client_library/default_log_handler.h"

%import "ur_client_library/types.h"

%import "ur_client_library/primary/package_header.h"

%interface_impl(PackageHeaderURPackage);
%template(PackageHeaderURPackage) urcl::comm::URPackage<urcl::primary_interface::PackageHeader>;
%interface_impl(urcl::comm::URPackage<urcl::primary_interface::PackageHeader>);
%import "ur_client_library/primary/primary_package.h"
%interface_impl(urcl::primary_interface::PrimaryPackage);

%import "ur_client_library/primary/robot_state.h"
%import "ur_client_library/primary/robot_state/kinematics_info.h"
%import "ur_client_library/primary/robot_message.h"

%interface_impl(PrimaryPackageConsumer);
%template(PrimaryPackageConsumer) urcl::comm::IConsumer<urcl::primary_interface::PrimaryPackage>;
%interface_impl(urcl::comm::IConsumer<urcl::primary_interface::PrimaryPackage>);
%import "ur_client_library/primary/abstract_primary_consumer.h"
%interface_impl(urcl::primary_interface::AbstractPrimaryConsumer);

%import "ur_client_library/primary/robot_message/version_message.h"

%interface_impl(PrimaryPackageParser);
%template(PrimaryPackageParser) urcl::comm::Parser<urcl::primary_interface::PrimaryPackage>;
%interface_impl(urcl::comm::Parser<urcl::primary_interface::PrimaryPackage>);
%import "ur_client_library/primary/primary_parser.h"

%import "ur_client_library/ur/datatypes.h"
%import "ur_client_library/ur/version_information.h"
%import "ur_client_library/ur/tool_communication.h"
%import "ur_client_library/ur/calibration_checker.h"
%import "ur_client_library/ur/dashboard_client.h"

//%warnfilter(302) urcl::UrDriver;
//%import "ur_client_library/ur/ur_driver.h"

%define AE_GCC
%define AE_ARCH_X64
%import "ur_client_library/queue/readerwriterqueue.h"
%import "ur_client_library/queue/atomicops.h"
%enddef
%enddef

////////////////

%include "ur_client_library/rtde/package_header.h"

%interface_impl(RtdePackageHeaderURPackage);
%template(RtdePackageHeaderURPackage) urcl::comm::URPackage<urcl::rtde_interface::PackageHeader>;
%interface_impl(urcl::comm::URPackage<urcl::rtde_interface::PackageHeader>);
%include "ur_client_library/rtde/rtde_package.h"

%include "ur_client_library/rtde/request_protocol_version.h"
%include "ur_client_library/rtde/control_package_setup_inputs.h"
%include "ur_client_library/rtde/control_package_pause.h"
%include "ur_client_library/rtde/get_urcontrol_version.h"
%include "ur_client_library/rtde/text_message.h"

%include "ur_client_library/rtde/rtde_writer.h"

%include "std_unique_ptr.i"
%unique_ptr(urcl::rtde_interface::DataPackage)
%include "ur_client_library/rtde/rtde_client.h"

%interface_impl(RTDEPackageParser);
%template(RTDEPackageParser) urcl::comm::Parser<urcl::rtde_interface::RTDEPackage>;
%interface_impl(urcl::comm::Parser<urcl::rtde_interface::RTDEPackage>);
%include "ur_client_library/rtde/rtde_parser.h"

%include "ur_client_library/rtde/control_package_start.h"
%include "ur_client_library/rtde/control_package_setup_outputs.h"
%include "ur_client_library/rtde/data_package.h"

