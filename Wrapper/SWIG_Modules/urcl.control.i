%module urcl__control;

// Own generic .i files
%include "_common.i"


// SWIG lib .i fles


%{
//Includes the header files in the wrapper code
#include "control/reverse_interface.h"
#include "control/script_sender.h"
#include "control/trajectory_point_interface.h"
%}

%import "control/reverse_interface.h"
%import "control/script_sender.h"
%import "control/trajectory_point_interface.h"

