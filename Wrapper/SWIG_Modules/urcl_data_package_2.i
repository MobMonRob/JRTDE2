%module urclDataPackage2;

// Own generic .i files
%include "_common.i"
%include "std_optional.i"

// SWIG lib .i fles
%include "std_string.i";

%{
	//std::move
	#include <utility>

	#include "ur_client_library/types.h"
    #include "ur_client_library/rtde/data_package.h"
%}

%include "ur_client_library/types.h"


%import "ur_client_library/comm/package.h"

%import "ur_client_library/rtde/package_header.h"

//%template(RtdePackageHeaderURPackage) urcl::comm::URPackage<urcl::rtde_interface::PackageHeader>;

//%import "ur_client_library/rtde/rtde_package.h"

%include "ur_client_library/rtde/data_package.h"

//SWIG Bug! Typemaps are not used for Templates inside %extend
//->Dokumentieren!
//Definition
//%extend urcl::rtde_interface::DataPackage {
%inline %{
	namespace urcl::rtde_interface {
		class DataPackage;
	}

	template <typename T>
	std::optional<T> getData2(urcl::rtde_interface::DataPackage * self, const std::string& name) {
		T value;
		bool success = self->getData(name, value);
		if (success) {
			return std::optional<T>(std::move(value));
		}
		return std::optional<T>(std::nullopt);
	}

	// T & val
	// in data_package.h
	// But will be copied
	template <typename T>
	bool setData2(urcl::rtde_interface::DataPackage * self, const std::string& name, const T & val) {
		return self->setData(name, val);
	}
%}
//};

%define %getSetData(NAMESPACE, TYPE)

%StdOptional(NAMESPACE, TYPE)

%template(getData2_ ## TYPE) getData2<NAMESPACE TYPE>;
%template(setData2_ ## TYPE) setData2<NAMESPACE TYPE>;

%extend urcl::rtde_interface::DataPackage {
	#if defined(SWIG)
	%proxycode %{
		public java.util.Optional<$typemap(jboxtype, NAMESPACE TYPE)> getData_ ## TYPE($typemap(jstype, const std::string&) name) {
			return getData2_ ## TYPE(this, name);
		}

		public boolean setData_ ## TYPE($typemap(jstype, const std::string&) name, $typemap(jstype, const NAMESPACE TYPE &) val) {
			return setData2_ ## TYPE(this, name, val);
		}
	%}
	#endif
};

%enddef

%getSetData( ,bool)
//%getSetData( ,uint8_t)
//%getSetData( ,uint32_t)
//%getSetData( ,uint64_t)
//%getSetData( ,int32_t)
//%getSetData( ,double)
//%getSetData(urcl::, vector3d_t)
//%getSetData(urcl::, vector6d_t)
//%getSetData(urcl::, vector6int32_t)
//%getSetData(urcl::, vector6uint32_t)
%getSetData(std::, string)

