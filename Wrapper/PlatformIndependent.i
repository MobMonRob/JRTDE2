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
#include "ur_client_library/ur/dashboard_client.h"
%}

//Parse the header files to generate wrappers
%include "ur_client_library/ur/dashboard_client.h"

