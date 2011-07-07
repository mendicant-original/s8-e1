NOTE: If in doubt about how to submit your project, read SUBMISSION_GUIDELINES

While it's nice to work with software stacks that are Ruby top to bottom,
sometimes it's necessary to take advantages of some of the great libraries that
other programming languages have to offer. There are many ways to integrate Ruby
code with non-Ruby code, but one of the most promising approaches is to use
Ruby-FFI.

In this exercise, you will be wrapping a third party library from a different
language using FFI (typically C libraries, but many languages support FFI), 
and then building an interesting library or application on top of that wrapper.

While working on this assignment, please keep the following guidelines in mind:

* You can choose any library you'd like to wrap, as long as it can run on OS X
or Linux, and is released under a GPLv3 compatible free software licenses (most
common free software licenses are compatible, but [check the full
listing](http://www.gnu.org/licenses/license-list.html#GPLCompatibleLicenses) if in doubt.)

* You not expected to wrap the entire API of the library you are targeting, but
you should choose a project that requires you to write a non-trivial amount of 
FFI code.

* The code that sits on top of your wrapper can either be a library that exposes
the functionality of the third party library in a way that's natural to Ruby, or
an application that depends on the functionality of the library you are
wrapping. In either case, you should have some realistic examples of how your
program is meant to be used.

* Your wrapper should ideally wrap a library that doesn't already have an FFI
wrapper built for it. However, if you are exposing a different aspect of a
library than other wrappers do, it might be okay to wrap something that has
already been targeted.

* You should make sure to enter your proposed project ideas into university-web 
so that the instructors can review them and also so that we can avoid having
multiple students target the same library.

* If you've never done FFI work before, the [wiki](https://github.com/ffi/ffi/wiki/) 
is a good place to start.
