/*GENERATED BY OBNC 0.16.1*/

#include ".obnc/Fmt.h"
#include <obnc/OBNC.h>
#include <stdio.h>

#define OBERON_SOURCE_FILENAME "Fmt.Mod"

void Fmt__Int_(OBNC_INTEGER value_, const char fmt_[], OBNC_INTEGER fmt_len, char dest_[], OBNC_INTEGER dest_len)
{
   sprintf(dest_, fmt_, value_); 
}


void Fmt__Real_(OBNC_REAL value_, const char fmt_[], OBNC_INTEGER fmt_len, char dest_[], OBNC_INTEGER dest_len)
{
   sprintf(dest_, fmt_, value_); 
}


void Fmt__Init(void)
{
}
