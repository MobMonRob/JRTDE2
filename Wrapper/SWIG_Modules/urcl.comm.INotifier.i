%module(directors="1") urcl__comm__INotifier;

// Own generic .i files
%include "_common.i"

// SWIG lib .i fles
%include <swiginterface.i>
%include <std_string.i>

%{
#include "comm/pipeline.h"
%}

//The Problem here is that SWIG uses the Base Destructor to delete the
//INotifier Director and the Base Destructor is not virtual.
//Would not be a Problem if SWIG would just use the
//INotifier Director Destructor.

//%feature("director") urcl::comm::INotifier;
//%include "comm/pipeline.h"

//SWIG Bug: SWIG uses the Base Destructor to delete the INotifier Director
//RTDE: Not a Bug if it ist not intended to be used polymorphicallly.
// - But against C++ recommendations that virtual methods imply virtual destructor.

//Workaround:

%ignore urcl::comm::INotifier;

// Name of Java (Proxy) classes
%typemap(jstype) urcl::comm::INotifier "$typemap(jstype, urcl::comm::Notifier)"
%typemap(jstype) urcl::comm::INotifier & = urcl::comm::INotifier;

// Pass CPtr, this, variables from Java (Proxy) class to intermediate JNI Java class.
// Java -> C++ on Java side
%typemap(javain) urcl::comm::INotifier "$typemap(javain, urcl::comm::Notifier)"
%typemap(javain) urcl::comm::INotifier & = urcl::comm::INotifier;

namespace urcl::comm {
	class INotifier{};
}

%feature("director") urcl::comm::Notifier;
%inline {
	namespace urcl::comm {
	class Notifier : public urcl::comm::INotifier {
	protected:
		Notifier() = default;
	public:
		virtual void started(std::string name) override {}
		virtual void stopped(std::string name) override {}
		virtual ~Notifier() = default;
	};
	}
}

