%{
#include <chrono>
%}

//Java -> C++
// const version auto generated
//$1: C++ Type
//$input: Java Type
%typemap(in) std::chrono::milliseconds
%{
    $1 = std::chrono::milliseconds($input);
%}


%typemap(jni) std::chrono::milliseconds "jlong"
%typemap(jtype) std::chrono::milliseconds "long"
%typemap(jstype) std::chrono::milliseconds "long"
%typemap(javain) std::chrono::milliseconds "$javainput"
%typemap(javaout) std::chrono::milliseconds {
    return $jnicall;
}

