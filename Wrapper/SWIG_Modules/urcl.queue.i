%module urcl__queue;

// Own generic .i files
%include "_common.i"


// SWIG lib .i fles


%{
#include "queue/readerwriterqueue.h"
#include "queue/atomicops.h"
%}

%define AE_GCC
%define AE_ARCH_X64
%import "queue/readerwriterqueue.h"
%import "queue/atomicops.h"
%enddef
%enddef

