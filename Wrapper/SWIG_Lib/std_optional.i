%include "std_optional_typemaps.i"

%{
	//std::optional
	#include <optional>
%}

%define %StdOptional(NAMESPACE, TYPE)

%StdOptional_typemaps(NAMESPACE, TYPE)
%template(Optional_ ## TYPE) std::optional<NAMESPACE TYPE>;

%enddef

%typemap(throws, throws="java.lang.NullPointerException") std::bad_optional_access & %{
	SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, $1.what());
%}

%catches(const std::bad_optional_access &) std::optional::value();

//SWIG Definition
namespace std {
	template <typename T>
	class optional {
	public:
		bool has_value();
		// Die Rückgabe muss als eine Kopie behandelt werden.
		// Sonst gibt es use-after-free Gefahr, wenn ein Pointer auf den inneren Wert zurück gegeben wird und in einer anderen Datenstruktur landet in Java.
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

