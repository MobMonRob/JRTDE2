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
//%include "std_shared_ptr.i";
//Important: http://www.swig.org/Doc4.0/Library.html#Library_std_shared_ptr
//%shared_ptr(std::vector<unsigned char>)

//Maybe above nspace Feature?
%include "std_string.i";
%include "arrays_java.i";
%include "std_vector.i"

//%rename (Result_Enum) ViconDataStreamSDK::CPP::Result::Enum;

//%template(VectorUint) std::vector<unsigned int>; //Gebraucht von DataStreamClient

//Interface cannot be instantiated
//%include <swiginterface.i>
//%interface_impl(ViconDataStreamSDK::CPP::IDataStreamClientBase);

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
%}

//Parse the header files to generate wrappers
%include "ur_client_library/control/reverse_interface.h"
%include "ur_client_library/control/script_sender.h"
%include "ur_client_library/control/trajectory_point_interface.h"
%include "ur_client_library/exceptions.h"
%include "ur_client_library/ur/datatypes.h"
%include "ur_client_library/ur/version_information.h"
%include "ur_client_library/ur/tool_communication.h"
%include "ur_client_library/ur/calibration_checker.h"
%include "ur_client_library/ur/dashboard_client.h"
%include "ur_client_library/ur/ur_driver.h"

%define _M_AMD64
%include "ur_client_library/queue/readerwriterqueue.h"
%include "ur_client_library/queue/atomicops.h"
%enddef

%include "ur_client_library/rtde/package_header.h"
%include "ur_client_library/rtde/request_protocol_version.h"
%include "ur_client_library/rtde/control_package_setup_inputs.h"
%include "ur_client_library/rtde/rtde_package.h"
%include "ur_client_library/rtde/control_package_pause.h"
%include "ur_client_library/rtde/get_urcontrol_version.h"
%include "ur_client_library/rtde/text_message.h"
%include "ur_client_library/rtde/rtde_client.h"
%include "ur_client_library/rtde/rtde_parser.h"
%include "ur_client_library/rtde/control_package_start.h"
%include "ur_client_library/rtde/control_package_setup_outputs.h"
%include "ur_client_library/rtde/rtde_writer.h"
%include "ur_client_library/rtde/data_package.h"
%include "ur_client_library/default_log_handler.h"
%include "ur_client_library/log.h"
%include "ur_client_library/types.h"
%include "ur_client_library/comm/producer.h"
%include "ur_client_library/comm/package.h"
%include "ur_client_library/comm/pipeline.h"
%include "ur_client_library/comm/parser.h"
%include "ur_client_library/comm/package_serializer.h"
%include "ur_client_library/comm/stream.h"
%include "ur_client_library/comm/tcp_server.h"
%include "ur_client_library/comm/tcp_socket.h"
%include "ur_client_library/comm/control_mode.h"
%include "ur_client_library/comm/shell_consumer.h"
%include "ur_client_library/comm/bin_parser.h"
%include "ur_client_library/primary/package_header.h"
%include "ur_client_library/primary/primary_package.h"
%include "ur_client_library/primary/robot_state.h"
%include "ur_client_library/primary/robot_state/kinematics_info.h"
%include "ur_client_library/primary/robot_message.h"
%include "ur_client_library/primary/abstract_primary_consumer.h"
%include "ur_client_library/primary/robot_message/version_message.h"
%include "ur_client_library/primary/primary_parser.h"

