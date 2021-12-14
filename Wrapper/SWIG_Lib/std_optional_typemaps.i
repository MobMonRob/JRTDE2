%{
	//std::move
	#include <utility>
%}

%define %StdOptional_typemaps(NAMESPACE, TYPE)
//////////////////////////////

//Java -> C++
%typemap(in) std::optional<NAMESPACE TYPE>
%{
	$1 = *(reinterpret_cast<NAMESPACE TYPE *>($input));
%}

//C++ -> Java
%typemap(out) std::optional<NAMESPACE TYPE >
%{
	*($1_type**)& $result = new $1_type(std::move($1));
%}

// Name of Java (Proxy) classes
%typemap(jstype) std::optional<NAMESPACE TYPE> "java.util.Optional<$typemap(jboxtype, NAMESPACE TYPE)>"

%typemap(javain) std::optional<NAMESPACE TYPE> "$javainput"

%typemap(javaout) std::optional<NAMESPACE TYPE>
%{
{
	long cPtr = $jnicall;
	if (cPtr == 0) return java.util.Optional.empty();
	$javaclassname theOpt = new $javaclassname(cPtr, true);
	return theOpt.toJavaOptional();
}
%}

//Java types in intermediate JNI Java class. Output of javain. long for pointers to classes.
%typemap(jtype) std::optional<NAMESPACE TYPE> "long"

//JNI C type. jlong for pointers to classes.
%typemap(jni) std::optional<NAMESPACE TYPE > "jlong"

//////////////////////////////

%typemap(in) std::optional<NAMESPACE TYPE> & %{
#error
%}
%typemap(out) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(jstype) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(javain) std::optional<NAMESPACE TYPE> & =std::optional<NAMESPACE TYPE>;
%typemap(javaout) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(jtype) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(jni) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;

%typemap(in) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE> &;
%typemap(out) std::optional<NAMESPACE TYPE> *
%{
#error
%}
%typemap(jstype) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>;
%typemap(javain) std::optional<NAMESPACE TYPE> * =std::optional<NAMESPACE TYPE>;
%typemap(javaout) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>;
%typemap(jtype) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>;
%typemap(jni) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>;


//////////////////////////////
%enddef

/*
//SWIG Definition
namespace std {
	template <typename T> class optional {};
}
*/

