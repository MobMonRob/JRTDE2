/*
 * Similar functionality to %pointer_class(TYPE, NAME)
 * of https://github.com/swig/swig/blob/v4.0.1/Lib/cpointer.i
 * But works with C++ references too.
*/


%{
#include <memory>
%}


%define %primitive_type_ptr(TYPE, NAME)


%ignore NAME::getNonOwningValuePtr;


%inline %{
    class NAME {
    public:
    NAME() : valuePtr(std::make_unique<TYPE>()) {
    }
    
    void setValue(TYPE value) {
        *valuePtr = value;
    }
    
    TYPE getValue() {
        return *valuePtr;
    }
    
    TYPE * getNonOwningValuePtr() {
        return valuePtr.get();
    }
        
    private:
        std::unique_ptr<TYPE> valuePtr;
    };
%}


//Java -> C++
// const version auto generated
//$1: C++ Type
//$input: Java Type
%typemap(in) TYPE *
%{
    //typemap_PTR
    //$1 is of Type: TYPE *
    $1 = ((reinterpret_cast<NAME *>($input))->getNonOwningValuePtr());
%}

//Java -> C++
// const version auto generated
//$1: C++ Type
//$input: Java Type
%typemap(in) TYPE &
%{
    //typemap_REF
    //$1 is of Type: TYPE *
    $1 = ((reinterpret_cast<NAME *>($input))->getNonOwningValuePtr());
%}

// Name of Java (Proxy) classes
%typemap(jstype) TYPE * "NAME"

// Pass CPtr, this, variables from Java (Proxy) class to intermediate JNI Java class. (Part of Java -> C++ way)
%typemap(javain) TYPE * "NAME.getCPtr($javainput)"

//Java types in intermediate JNI Java class. Output of javain. long for pointers to classes.
%typemap(jtype) TYPE * "long"

//JNI C type. jlong for pointers to classes.
%typemap(jni) TYPE * "jlong"


%typemap(jstype) TYPE & = TYPE *;
%typemap(javain) TYPE & = TYPE *;
%typemap(jtype) TYPE & = TYPE *;
%typemap(jni) TYPE & = TYPE *;


/*
%inline %{
TYPE testTYP (TYPE theInput) {
    NAME tmp = NAME();
    tmp.setValue(theInput);
    return *tmp.getNonOwningValuePtr();
}
    
TYPE testPTR (TYPE * theInput) {
    return *theInput;
}

TYPE testREF (TYPE & theInput) {
    return theInput;
}
%}
*/


%enddef

