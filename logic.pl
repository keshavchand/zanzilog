% Group
% Relation
groupL(member, Group, User) :-
	group(member, Group, User), user(User).

% Organization 
% Relation
organizationL(owner, Org, User) :-
	organization(owner, Org, User), user(User).

organizationL(member, Org, User) :-
	organization(member, Org, User);
	organization(owner, Org, User); (
		group(member, Group, User),
		organization(member, Org, Group)
	).

% Permission
organizationL(create_project, Organziation, User) :-
	organizationL(owner, Organziation, User);
	organizationL(member, Organziation, User).

organizationL(view, Organziation, User) :-
	organizationL(owner, Organziation, User);
	organizationL(member, Organziation, User).

organizationL(delete, Organziation, User) :-
	organizationL(owner, Organziation, User).

% Project
% Relation
projectL(owner, Project, User) :-
	project(owner, Project, User), user(User).

projectL(parent, Project, Org) :-
	project(parent, Project, Org), organization(_, Org, _).

projectL(member, Project, User) :-
	project(owner, Project, User);
	project(member, Project, User); (
		group(member, Group, User),
		project(member, Project, Group)
	).

% Permission
projectL(create_component, Project, User) :-
	% owner or member or view permission in the organization
	projectL(owner, Project, User);
	projectL(member, Project, User); (
		projectL(parent, Project, ParentProject),
		organizationL(view, ParentProject, User)
	).

projectL(view, Project, User) :-
	% owner or member or view permission in the organization
	projectL(owner, Project, User);
	projectL(member, Project, User); (
		projectL(parent, Project, ParentProject),
		organizationL(view, ParentProject, User)
	).

% Component
% Relation
componentL(owner, Component, User) :-
	component(owner, Component, User), user(User).

componentL(parent, Component, Project) :-
	component(parent, Component, Project), project(_, Project, _).

componentL(reader, Component, User) :-
	component(reader, Component, User);
	component(reader, Component, Group), group(member, Group, User).

componentL(writer, Component, User) :-
	component(writer, Component, User);
	component(writer, Component, Group), group(member, Group, User).

% Permission
componentL(write, Component, User) :-
	componentL(writer, Component, User);
	componentL(owner, Component, User).

componentL(read, Component, User) :-
	componentL(reader, Component, User);
	componentL(owner, Component, User); (
		componentL(parent, Component, Project),
		projectL(view, Project, User)
	).
