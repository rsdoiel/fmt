MODULE FmtTest;
  IMPORT Out, Fmt;

PROCEDURE TestInt(): BOOLEAN;
  VAR
    fmtString : ARRAY 24 OF CHAR;
    dest : ARRAY 128 OF CHAR;
    i : INTEGER;
BEGIN
    i := 42;
    fmtString := "%d";
    Fmt.Int(i, fmtString, dest);
    Out.String(dest);Out.Ln;
    RETURN TRUE
END TestInt;

PROCEDURE TestReal(): BOOLEAN;
  VAR
    fmtString : ARRAY 24 OF CHAR;
    dest : ARRAY 128 OF CHAR;
    r : REAL;
BEGIN
    r := 3.145;
    fmtString := "%f";
    Fmt.Real(r, fmtString, dest);
    Out.String(dest);Out.Ln;
    RETURN TRUE
END TestReal;

BEGIN
  ASSERT(TestInt());
  ASSERT(TestReal());
  Out.String("Success!");Out.Ln;
END FmtTest.
