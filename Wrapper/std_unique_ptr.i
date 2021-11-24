//Usage:
//%include "std_unique_ptr.i"
//%unique_ptr(InnerType)

//Credits:
//https://github.com/swig/swig/blob/v4.0.1/Lib/java/std_auto_ptr.i

//Further reading:
//https://stackoverflow.com/questions/27693812/how-to-handle-unique-ptrs-with-swig/27699663#27699663
//https://github.com/swig/swig/issues/692
//https://github.com/swig/swig/pull/1722

/*
    The typemaps here allow to handle functions returning std::unique_ptr<>,
    which is the most common use of this type. If you have functions taking it
    as parameter, these typemaps can't be used for them and you need to do
    something else (e.g. use shared_ptr<> which SWIG supports fully).
 */

%{
#include <memory>
%}

%define %unique_ptr(TYPE)

/////////////////////////////////////////////////////
// out
/////////////////////////////////////////////////////

// C++ -> Java in JNI
%typemap (out) std::unique_ptr<TYPE> %{
   jlong lpp = 0;
   *(TYPE**) &lpp = $1.release();
   $result = lpp;
%}

// C++ -> Java in JNI
%typemap (out) std::unique_ptr<TYPE> & %{
   jlong lpp = 0;
   *(TYPE**) &lpp = $1->get();
   $result = lpp;
%}

// C++ -> Java in JNI
%typemap (out) std::unique_ptr<TYPE> * %{
   jlong lpp = 0;
   *(TYPE**) &lpp = $1->get();
   $result = lpp;
%}

/////////////////////////////////////////////////////
// javaout
/////////////////////////////////////////////////////

// Java Code
%typemap(javaout) std::unique_ptr<TYPE> {
//TM_javaout
     long cPtr = $jnicall;
     if (cPtr == 0) return null;
     // true here indicates the ownership transfer to java
     return new $typemap(jstype, TYPE)(cPtr, true);
}

// Java Code
%typemap(javaout) std::unique_ptr<TYPE> & {
//TM_javaout&
     long cPtr = $jnicall;
     if (cPtr == 0) return null;
     // false here indicates no ownership transfer to java
     return new $typemap(jstype, TYPE)(cPtr, false);
}

// Java Code
%typemap(javaout) std::unique_ptr<TYPE> * {
//TM_javaout*
     long cPtr = $jnicall;
     if (cPtr == 0) return null;
     // false here indicates no ownership transfer to java
     return new $typemap(jstype, TYPE)(cPtr, false);
}


/////////////////////////////////////////////////////
// (Other)
/////////////////////////////////////////////////////

%typemap (jni) std::unique_ptr<TYPE> "jlong"
%typemap (jtype) std::unique_ptr<TYPE> "long"
%typemap (jstype) std::unique_ptr<TYPE> "$typemap(jstype, TYPE)"

// std::unique_ptr<TYPE> &
// const version auto generated
%typemap(jni) std::unique_ptr<TYPE> & = std::unique_ptr<TYPE>;
%typemap(jtype) std::unique_ptr<TYPE> & = std::unique_ptr<TYPE>;
%typemap(jstype) std::unique_ptr<TYPE> & = std::unique_ptr<TYPE>;

// std::unique_ptr<TYPE> *
// const version auto generated
%typemap(jni) std::unique_ptr<TYPE> * = std::unique_ptr<TYPE>;
%typemap(jtype) std::unique_ptr<TYPE> * = std::unique_ptr<TYPE>;
%typemap(jstype) std::unique_ptr<TYPE> * = std::unique_ptr<TYPE>;

%template() std::unique_ptr<TYPE>;

%enddef

namespace std {
   template <class T> class unique_ptr {};
}

