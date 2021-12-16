%module urcl__rtde__data_package;

// Own generic .i files
%include "_common.i"
%include "std_optional.i"

// SWIG lib .i fles
%include "std_string.i";
%include "std_array.i"
%include "std_vector.i"
%include "stdint.i"

///////////////////////////////////////////////////////////

//SWIG BUG: Not part of %include "std_array.i"
%{
	//std::array
	#include <array>
%}

// Needs to be before primitive_type_ptr
// to ensure primitive_type_ptr is not used here
// Defined in types.h
%template(Vector3double) std::array<double, 3>;
%template(Vector6double) std::array<double, 6>;
%template(Vector6int32) std::array<int32_t, 6>;
%template(Vector6uint32) std::array<uint32_t, 6>;

%template (VectorString) std::vector<std::string>;

///////////////////////////////////////////////////////////

%{
	//std::move
	#include <utility>

	#include "types.h"
    #include "rtde/data_package.h"
%}

///////////////////////////////////////////////////////////

%ignore urcl::rtde_interface::DataPackage::serializePackage;
%ignore urcl::rtde_interface::DataPackage::parseWith;

%warnfilter(401) urcl::rtde_interface::DataPackage;

///////////////////////////////////////////////////////////

%include "types.h"

/*
%import "comm/package.h"

%import "rtde/package_header.h"

%template(RtdePackageHeaderURPackage) urcl::comm::URPackage<urcl::rtde_interface::PackageHeader>;

%import "rtde/rtde_package.h"
*/

%include "rtde/data_package.h"

///////////////////////////////////////////////////////////

//SWIG Bug! Typemaps are not used for Templates inside %extend
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

///////////////////////////////////////////////////////////

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

///////////////////////////////////////////////////////////

// Defined in "types.h"
%getSetData( ,bool)
%getSetData( ,uint8_t)
%getSetData( ,uint32_t)
%getSetData( ,uint64_t)
%getSetData( ,int32_t)
%getSetData( ,double)
%getSetData(urcl::, vector3d_t)
%getSetData(urcl::, vector6d_t)
%getSetData(urcl::, vector6int32_t)
%getSetData(urcl::, vector6uint32_t)
%getSetData(std::, string)

