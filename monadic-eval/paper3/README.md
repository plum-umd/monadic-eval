This directory contains the Scribble source code for the literate
version of "Definitional Abstract Interpreters for Higher-Order
Languages."

To build the paper, you will need:

- XeLaTeX
- Racket v6.9.
- raco pkg install monadic-eval/
- Modified version of the latest version of acmart.cls.

Patching to use (a modified version of!) the latest version of
acmart.cls:

- Get the source code from https://github.com/borisveytsman/acmart
- Comment out line 2613 of acmart.dtx (using libertine)
- latex acmart.ins
- mv acmart.cls RACKET_HOME/share/pkgs/scribble-lib/scribble/acmart/

Run:
```
   raco scribble ++style style.tex --xelatex main.scrbl
```
