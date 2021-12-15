%{
	//std::move
	#include <utility>
%}

%define %StdOptional_typemaps(NAMESPACE, TYPE)
//////////////////////////////

//Java -> C++ on C++ side
%typemap(in) std::optional<NAMESPACE TYPE>
%{
	$1 = *(reinterpret_cast<NAMESPACE TYPE *>($input));
%}

//C++ -> Java on C++ side
%typemap(out) std::optional<NAMESPACE TYPE >
%{
	*($1_type**)& $result = new $1_type(std::move($1));
%}

// Name of Java (Proxy) classes
%typemap(jstype) std::optional<NAMESPACE TYPE> "java.util.Optional<$typemap(jboxtype, NAMESPACE TYPE)>"

// Pass CPtr, this, variables from Java (Proxy) class to intermediate JNI Java class.
// Java -> C++ on Java side
%typemap(javain) std::optional<NAMESPACE TYPE> "$javainput"

// Get output of function call of intermediate JNI Java class.
// C++ -> Java on Java side
%typemap(javaout) std::optional<NAMESPACE TYPE>
%{
{
	long cPtr = $jnicall;
	if (cPtr == 0) return java.util.Optional.empty();
	$javaclassname theOpt = new $javaclassname(cPtr, true);
	return theOpt.toJavaOptional();
}
%}

//Java types in intermediate JNI Java class. Output of javain. Input of javaout. long for pointers to classes.
%typemap(jtype) std::optional<NAMESPACE TYPE> "long"

//JNI C type. jlong for pointers to classes.
%typemap(jni) std::optional<NAMESPACE TYPE > "jlong"

//////////////////////////////

%typemap(in) std::optional<NAMESPACE TYPE> &
%{
	$1 = reinterpret_cast<NAMESPACE TYPE *>($input);
%}
%typemap(out) std::optional<NAMESPACE TYPE> &
%{
	*($1_basetype**)& $result = new $1_basetype(*$1);
%}
%typemap(jstype) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(javain) std::optional<NAMESPACE TYPE> & =std::optional<NAMESPACE TYPE>;
%typemap(javaout) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(jtype) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;
%typemap(jni) std::optional<NAMESPACE TYPE> & = std::optional<NAMESPACE TYPE>;

//////////////////////////////

%typemap(in) std::optional<NAMESPACE TYPE> *
%{
#error
%}
%typemap(out) std::optional<NAMESPACE TYPE> *
%{
#error
%}
%typemap(jstype) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE> &;
%typemap(javain) std::optional<NAMESPACE TYPE> * =std::optional<NAMESPACE TYPE>  &;
%typemap(javaout) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE> &;
%typemap(jtype) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>  &;
%typemap(jni) std::optional<NAMESPACE TYPE> * = std::optional<NAMESPACE TYPE>  &;


//////////////////////////////
%enddef

/*
//SWIG Definition
namespace std {
	template <typename T> class optional {};
}
*/

