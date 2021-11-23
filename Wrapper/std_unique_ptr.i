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

%define %unique_ptr(TYPE)

%typemap (jni) std::unique_ptr<TYPE > "jlong"
%typemap (jtype) std::unique_ptr<TYPE > "long"
%typemap (jstype) std::unique_ptr<TYPE > "$typemap(jstype, TYPE)"

// C++ -> Java in JNI
%typemap (out) std::unique_ptr<TYPE > %{
//TM_out
   jlong lpp = 0;
   *(TYPE**) &lpp = $1.release();
   $result = lpp;
%}

// Java Code
%typemap(javaout) std::unique_ptr<TYPE > {
//TM_javaout
     long cPtr = $jnicall;
     // true indicates here the ownership transfer to java
     return (cPtr == 0) ? null : new $typemap(jstype, TYPE)(cPtr, true);
}

%template() std::unique_ptr<TYPE >;

%enddef

namespace std {
   template <class T> class unique_ptr {};
}

