%module urclDataPackage;

//%include "_common.i"

%feature("nspace");
//Muss unbedingt vor den Template Instanzierungen stehen, damit die zugreifbar bleiben.
//Refer to end of section of http://www.swig.org/Doc4.0/Java.html#Java_code_typemaps
//Nur notwendig, wenn nspace Feature aktiv
SWIG_JAVABODY_PROXY(public, public, SWIGTYPE)
SWIG_JAVABODY_TYPEWRAPPER(public, public, public, SWIGTYPE)
SWIG_JAVABODY_METHODS(public, public, SWIGTYPE)

// SWIG lib .i fles
%include "std_string.i";
%include "std_array.i"
%include "std_vector.i"
//%include "stdint.i"

// Own generic .i files
%include "primitive_type_ptr.i"

//Fixes [...]SwigJNI class to invoke NativeLibLoader
%pragma(java) jniclassimports=%{
import de.dhbw.rahmlab.urcl.nativelib.NativeLibLoader;
%}

%pragma(java) jniclasscode=%{
static {
	NativeLibLoader.load();
}
%}

// Import in all Proxy Classes.
// Um trotz "nspace" herauszufinden, wo die "SWIGTYPE_p_[...]" Stummel Proxy Klassen benutzt werden via netbeans "find usages".
%typemap(javaimports) SWIGTYPE
%{
import de.dhbw.rahmlab.urcl.impl.*;
%}

//Unknown Doxygen command
#pragma SWIG nowarn=560


///////////////////////////////////////////////////////////77

%apply int { int32_t };
%apply const int & { const int32_t & };

%apply unsigned char { uint8_t };
%apply const unsigned char & { const uint8_t & };

%apply unsigned int { uint32_t };
%apply const unsigned int & { const uint32_t & };

%apply unsigned long long { uint64_t };
%apply const unsigned long long & { const uint64_t & };

// Needs to be before primitive_type_ptr
// to ensure primitive_type_ptr is not used here
// Defined in types.h
%template(vector3double) std::array<double, 3>;
%template(vector6double) std::array<double, 6>;
%template(vector6int32) std::array<int32_t, 6>;
%template(vector6uint32) std::array<uint32_t, 6>;

%primitive_type_ptr(bool, BoolContainer);
%primitive_type_ptr(uint8_t, UInt8Container)
%primitive_type_ptr(uint32_t, UInt32Container)
%primitive_type_ptr(uint64_t, UInt64Container)
%primitive_type_ptr(int32_t, Int32Container)
%primitive_type_ptr(double, DoubleContainer)
%primitive_type_ptr(std::string, StdStringContainer)

%template (StringVector) std::vector<std::string>;

//%ignore urcl::rtde_interface::DataPackage::serializePackage;

%{
	#include "ur_client_library/types.h"
    #include "ur_client_library/rtde/data_package.h"
%}

%include "ur_client_library/types.h"


%import "ur_client_library/comm/package.h"

%import "ur_client_library/rtde/package_header.h"

//%template(RtdePackageHeaderURPackage) urcl::comm::URPackage<urcl::rtde_interface::PackageHeader>;

//%import "ur_client_library/rtde/rtde_package.h"

%include "ur_client_library/rtde/data_package.h"

%define %getSetDataTemplateNS(NAMESPACE, TYPE)
%template(getData_ ## TYPE) urcl::rtde_interface::DataPackage::getData<NAMESPACE ## TYPE>;
%template(setData_ ## TYPE) urcl::rtde_interface::DataPackage::setData<NAMESPACE ## TYPE>;
%enddef

%define %getSetDataTemplate(TYPE)
%getSetDataTemplateNS( , TYPE)
%enddef

%getSetDataTemplate(bool)
%getSetDataTemplate(uint8_t)
%getSetDataTemplate(uint32_t)
%getSetDataTemplate(uint64_t)
%getSetDataTemplate(int32_t)
%getSetDataTemplate(double)
%getSetDataTemplateNS(urcl::, vector3d_t)
%getSetDataTemplateNS(urcl::, vector6d_t)
%getSetDataTemplateNS(urcl::, vector6int32_t)
%getSetDataTemplateNS(urcl::, vector6uint32_t)
%getSetDataTemplateNS(std::, string)

