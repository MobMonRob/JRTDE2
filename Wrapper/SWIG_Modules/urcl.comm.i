%module urcl__comm;

// Own generic .i files
%include "_common.i"
%include "primitive_type_ptr.i"


// SWIG lib .i fles
%include <swiginterface.i>
%include <std_string.i>
%include <stdint.i>


%primitive_type_ptr(size_t, SizeTContainer)

#define __WORDSIZE 64
%import "/usr/include/x86_64-linux-gnu/bits/typesizes.h";
%import "/usr/include/x86_64-linux-gnu/bits/time64.h";
%import "/usr/include/x86_64-linux-gnu/bits/types.h";
%include "/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h";
#undef __WORDSIZE

%{
#include "comm/producer.h"
#include "comm/package.h"
#include "comm/pipeline.h"
#include "comm/parser.h"
#include "comm/package_serializer.h"
#include "comm/stream.h"
#include "comm/tcp_server.h"
#include "comm/tcp_socket.h"
#include "comm/control_mode.h"
#include "comm/shell_consumer.h"
#include "comm/bin_parser.h"
%}


/*
 * Deactivated serialization.
 * Too low-levely.
 * If needed: turn back on.
*/
///////////////////////////
%ignore generateSerializedRequest;
%ignore serializeHeader;
//parseWith benötigt, damit DataPackage nicht abstrakt ist in Java
//%ignore parseWith;
%ignore serializePackage;
//%warnfilter(403);
///////////////////////////
//%include "various.i"
//%apply uint8_t* NIOBUFFER { unsigned char * buf };
//%apply uint8_t* NIOBUFFER { unsigned char * buffer };
//The serialization functions return the length of the new buffer.
//This seems to be incompatbile with java.nio.buffer
//because there might be boundary checks with outdated
//capacity values. And there is no way to change them.

//Inspiration:
//https://github.com/swig/swig/blob/v4.0.1/Lib/java/various.i
//->Lösung wäre: Eigene C++ Klasse bauen, die das berücksichtigt und keine Boundary Checks macht.
//->Es sollte eine Möglichkeit geben, den Inhalt dann auf einen Schlag in ein Java Array oder ein Java NIO zu kovertieren. In beide Richtungen.
//->Keine Möglichkeit geben, Elemente raus zu holen oder rein zu füllen.
//Es muss die Möglickeit geben, den Inhalt in Java zu allozieren.
//Aber auch, dass der Inhalt in C++ alloziert wird und die neue Größe dann später zugewiesen wird.
//->Da muss man dann höllisch aufpassen.

//%import "comm/parser.h"
//%import "comm/package_serializer.h"

%ignore urcl::comm::BinParser::parse;
%ignore urcl::comm::BinParser::parseRemainder;
%ignore urcl::comm::BinParser::rawData;
%include "comm/bin_parser.h"

//%template(PrimaryPackageParser) urcl::comm::Parser<urcl::primary_interface::PrimaryPackage>;
//%import "primary/primary_parser.h"

//%template(RTDEPackageParser) urcl::comm::Parser<urcl::rtde_interface::RTDEPackage>;
//%std_vector_unique_ptr(RTDEPackageVector, urcl::rtde_interface::RTDEPackage)
//%include "rtde/rtde_parser.h"
///////////////////////////
// End Serialization


// Begin Imports
///////////////////////////
%import "comm/producer.h"
%import "comm/package.h"
%import "comm/tcp_server.h"
%import "comm/stream.h"
%import "comm/control_mode.h"
%import "comm/shell_consumer.h"
///////////////////////////
// End Imports


// Begin Includes
///////////////////////////
%include "comm/tcp_socket.h"

/*
 * Usage:
 * Inherit from INotifierSwigImpl to use Director Functionality.
*/
//The Problem here is that SWIG uses the Base Destructor to delete the
//INotifier Director and the Base Destructor is not virtual.
//Would not be a Problem if SWIG would just use the
//INotifier Director Destructor.
//%feature("director") urcl::comm::INotifier;

//SWIG Bug: SWIG uses the Base Destructor to delete the INotifier Director
//RTDE: Not a Bug if it ist not intended to be used polymorphicallly.
// - But against C++ recommendations that virtual methods imply virtual destructor.

//Just don't use INotifierSWIGImpl.
//But instead: Inherit from Notifier.java.
//And use INotifier.java to point to it.
%interface_impl(urcl::comm::INotifier)
%include "comm/pipeline.h"
%feature("director") urcl::comm::Notifier;
%inline {
    namespace urcl::comm {
        class Notifier : public urcl::comm::INotifier {
            public:
            virtual ~Notifier() {
            }
        };
    }
}
///////////////////////////
// End Includes

