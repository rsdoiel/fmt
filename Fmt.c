#include ".obnc/Fmt.h"
#include <obnc/OBNC.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

void Fmt__Int_(OBNC_INTEGER value, char fmtString[], char dest[])
{
    /* Populate buf with the formated version of value */
    sprintf(buf, fmtString, value);
}

void Fmt__Real_(OBNC_REAL value, char fmtString[], char dest[])
{
    /* Populate dest with the format of value */
    sprintf(dest, fmtString, value);
}

