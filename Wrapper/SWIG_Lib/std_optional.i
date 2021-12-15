%include "std_optional_typemaps.i"

%{
	//std::optional
	#include <optional>
%}

%define %StdOptional(NAMESPACE, TYPE)

%template(Optional_ ## TYPE) std::optional<NAMESPACE TYPE>;

//They shall not apply to std:optional.
//Therefore after %template
%StdOptional_typemaps(NAMESPACE, TYPE)

%enddef

%typemap(throws, throws="java.lang.NullPointerException") std::bad_optional_access & %{
	SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, $1.what());
	return 0;
%}

%catches(const std::bad_optional_access &) std::optional::value();

//%javamethodmodifiers std::optional::has_value "private";
//%javamethodmodifiers std::optional::value "private";

//SWIG Definition
namespace std {
	template <typename T>
	class optional {
	public:
		optional();

		//Copy will be passed to move constructor
		optional(T value);

		bool has_value();

		//The return value must be daclared as value Type to ensure that the corresponding Typemap will be used and the value will be copied in the wrap.cpp. (In the original Definition it is a Reference)
		//Otherwise there is the danger of use-after-free, if a pointer of the inner value is returned and used in another datastructure in Java afterwards.
		const T value();

		#if defined(SWIG)
		%proxycode %{
			public java.util.Optional<$typemap(jboxtype, T)> toJavaOptional() {
				if (this.has_value()) {
					return java.util.Optional.of(this.value());
				}
				else {
					return java.util.Optional.empty();
				}
			}
		%}
		#endif
	};
}

