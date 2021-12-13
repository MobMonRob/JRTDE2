%{
	//std::optional
	#include <optional>
%}

%typemap(throws, throws="java.lang.NullPointerException") std::bad_optional_access & %{
	SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, $1.what());
%}

%catches(const std::bad_optional_access &) std::optional::value();

//Declaration
namespace std {
	template <typename T>
	class optional;
};


%define %StdOptional(NAMESPACE, TYPE)


//////////////////////////////


%typemap(out) std::optional<NAMESPACE TYPE>
%{
	//typout
	*($1_type*)& $result = $1;
%}

// Name of Java (Proxy) classes
%typemap(jstype) std::optional<NAMESPACE TYPE> "java.util.Optional<$typemap(jboxtype, NAMESPACE TYPE)>"

%typemap(javaout) std::optional<NAMESPACE TYPE>
%{
	long cPtr = $jnicall(swigCPtr, this, name);
	if (cPtr == 0) return java.util.Optional.empty();
	$javaclazzname theOpt = new $javaclazzname(swigCPtr, $owner);
	return theOpt.toJavaOptional();
%}

//Java types in intermediate JNI Java class. Output of javain. long for pointers to classes.
%typemap(jtype) std::optional<NAMESPACE TYPE> "long"

//JNI C type. jlong for pointers to classes.
%typemap(jni) std::optional<NAMESPACE TYPE> "jlong"

//////////////////////////////

%typemap(out) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(jstype) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(javaout) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(jtype) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(jni) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;


%typemap(out) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>;
%typemap(jstype) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>;
%typemap(javaout) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>;
%typemap(jtype) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>;
%typemap(jni) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>;


//////////////////////////////

//Specialisation
namespace std {
	template <>
	class optional<NAMESPACE TYPE> {
	public:
		bool has_value();
		// Die Rückgabe muss als eine Kopie behandelt werden.
		// Sonst gibt es use-after-free Gefahr, wenn ein Pointer auf den inneren Wert zurück gegeben wird und in einer anderen Datenstruktur landet in Java.
		const NAMESPACE TYPE value();
		#if defined(SWIG)
		%proxycode %{
			public java.util.Optional<$typemap(jboxtype, NAMESPACE TYPE)> toJavaOptional() {
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


%template(Optional_ ## TYPE) std::optional<NAMESPACE TYPE>;

%enddef

