%module urcl__primary;

// Own generic .i files
%include "_common.i"


// SWIG lib .i fles
//Make get_Cptr public
//#define SWIG_SHARED_PTR_TYPEMAPS(CONST, TYPE...) SWIG_SHARED_PTR_TYPEMAPS_IMPLEMENTATION(public, public, CONST, TYPE)
//%include <std_shared_ptr.i>
//Important: http://www.swig.org/Doc4.0/Library.html#Library_std_shared_ptr


%{
#include "primary/package_header.h"
#include "primary/primary_package.h"
#include "primary/robot_state.h"
#include "primary/robot_state/kinematics_info.h"
#include "primary/robot_message.h"
#include "primary/abstract_primary_consumer.h"
#include "primary/robot_message/version_message.h"
#include "primary/primary_parser.h"
%}

// Begin Imports
///////////////////////////
%import "primary/package_header.h"

//%ignore urcl::primary_interface::PrimaryPackage::consumeWith;
//%shared_ptr(urcl::comm::URPackage<urcl::primary_interface::PackageHeader>)
//%shared_ptr(urcl::primary_interface::PrimaryPackage)
//%shared_ptr(urcl::primary_interface::RobotState
//%shared_ptr(urcl::primary_interface::KinematicsInfo)
//%shared_ptr(urcl::primary_interface::RobotMessage)
//%shared_ptr(urcl::primary_interface::VersionMessage)
//%template(PackageHeaderURPackage) urcl::comm::URPackage<urcl::primary_interface::PackageHeader>;
//%import "primary/primary_package.h"

//%import "primary/robot_state.h"
//%import "primary/robot_state/kinematics_info.h"
//%import "primary/robot_message.h"

//%template(PrimaryPackageConsumer) urcl::comm::IConsumer<urcl::primary_interface::PrimaryPackage>;
//%import "primary/abstract_primary_consumer.h"

//%interface_impl(urcl::primary_interface::AbstractPrimaryConsumer);
//%import "primary/robot_message/version_message.h"
///////////////////////////
// End Imports

