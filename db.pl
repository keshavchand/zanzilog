user(alice).
user(jane).
user(bob).
user(smith).

group(member, g1, alice).

component(parent, componentA, projectA).
component(writer, componentA, jane).

organization(member, orgA, bob).
organization(owner, orgA, alice).

project(member, projectA, jane).
project(parent, projectA, orgA).

:- [logic].

mustTrue :-
	organizationL(owner, orgA, alice),
	projectL(view, projectA, bob),
	organizationL(delete, orgA, alice).

mustFalse :-
	componentL(read, componentA, smith),
	componentL(delete, componentA, chuck),
	projectL(delete, projectA, alice).

runTest :-
	mustTrue,
	\+ mustFalse,
	write('All tests passed!').
