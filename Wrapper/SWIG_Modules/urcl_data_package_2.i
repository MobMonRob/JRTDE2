%module urclDataPackage2;

%include "_common.i"
%include "std_optional.i"

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

%define %getSetData(NAMESPACE, TYPE)

%StdOptional(NAMESPACE, TYPE);

%template(getData_ ## TYPE) urcl::rtde_interface::DataPackage::getData2<NAMESPACE TYPE>;
%template(setData_ ## TYPE) urcl::rtde_interface::DataPackage::setData2<NAMESPACE TYPE>;

%enddef

//Definition
%extend urcl::rtde_interface::DataPackage {
	template <typename T>
	std::optional<T> getData2(const std::string& name) {
		T value;
		bool success = $self->getData(name, value);
		if (success) {
			return std::optional<T>(std::move(value));
		}
		return std::optional<T>(std::nullopt);
	}

	// T & val
	// in data_package.h
	// But will be copied
	template <typename T>
	bool setData2(const std::string& name, const T & val) {
		return $self->setData(name, val);
	}
};

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

