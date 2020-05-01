(**Fmt.Mod provides a simple wrapper for formatting Oberon INTEGER and REAL values
when compiling using the OBNC compiler.
 *)
MODULE Fmt;

(*implemented in C *)

PROCEDURE Int*(value : INTEGER; fmtString : ARRAY OF CHAR; VAR dest : ARRAY OF CHAR);
BEGIN
(**Implementation is written in C in Fmt.c. *)
END Int;

PROCEDURE Real*(value : REAL; fmtString : ARRAY OF CHAR; VAR dest : ARRAY OF CHAR);
BEGIN
(**Implementation is written in C in Fmt.c. *)
END Real;

END Fmt.
