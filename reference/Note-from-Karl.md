From: comp.lang.oberon
Date: March 7, 2020

On 2020-03-06 08:48, Hưng Gia wrote:
> Could you adjust the behavior of it to print normal floating point
> number instead of scientific notation? If it's the your design could
> you provide a way to print floating point number in the normal
> format? I can't found any procedure to it.

As mentioned by Guy T, it's better to define a new procedure. The Out
module implements the procedure Real according to the specification in
"The Oakwood Guidelines for Oberon-2 Compiler Developers."

Below is an example of how you can interface to the C function printf
(see also the manual page for the obnc command).

MODULE Print;

        (*implemented in C*)

        PROCEDURE Real*(x: REAL);
        END Real;

END Print.


Print.c:

#include ".obnc/Print.h"
#include <stdio.h>

void Print__Real_(OBNC_REAL x)
{
        printf("%f", x);
}


void Print__Init(void)
{
}


MODULE PrintTest;

        IMPORT Out, Print;

BEGIN
        Print.Real(3.1415926535);
        Out.Ln
END PrintTest.

> I tried to use your ext library to convert real to string but it
> didn't work. The procedure take three parameters and not suitable to
> use like what I desire >
> Out.String(extConvert.RealToString(Math.sqrt(2)));

In Oberon a procedure can only return scalar values. That's why
RealToString is defined the way it is. Also, the procedure uses the same
format as Out.Real.


-- Karl


From: comp.lang.oberon
Date: March 8, 2020

On 2020-03-08 08:13, Hưng Gia wrote:
> Many libraries make use of variable argument list. If I want to
> create a binding for Oberon to work with ONBC, how could I implement
> it? Or I have used Oberon wrong all the time, that Oberon was
> designed to be a standalone language and everything should be done on
> Oberon alone and interfacing to other libraries not needed? I think
> Oberon is a general purpose language and want to do GUI in Oberon, so
> I plan to create a binding for GTK+. I don't know if I could
> accomplish this job but the first show stopper is va_list.

Variadic functions in C break type safety. That's one of the reasons
there is no similar feature in Oberon.

> Another problem is I have to doubled the work. First to write an
> Oberon module then having to edit the generated C source which is the
> the actual binding. So I asked if we could make it easier to use a
> header like solution, .def file as GNU Modula-2 does, to simplify
> the process? So I only have to write the .def file once then just
> use it.

Mapping Oberon procedures directly to C functions can only be done in
some cases. For instance, a C function can return a character pointer
but an Oberon procedure cannot. Moreover, if you pass a non-terminated
string to an Oberon procedure which is implemented in C you can catch
the invalid parameter with an assertion. If the C function is called
directly the program will probably crash.


-- Karl
