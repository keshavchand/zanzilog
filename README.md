# Implementing Zanzibar but in Prolog

## Running
Step1: Install prolog `apt install swi-prolog`

Step2: Run `swipl -s db.pl`

```bash
$ swipl -s db.pl

Welcome to SWI-Prolog (threaded, 64 bits, version 9.2.2)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit https://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- mustTrue.
true .

?- mustFalse.
false.

?- runTest.
All tests passed!
true .
```

## Sample Questions
Can Alice view ProjectA

?- projectL(view, projectA, bob).
true.

?- projectL(view, projectA, smith).
false.
