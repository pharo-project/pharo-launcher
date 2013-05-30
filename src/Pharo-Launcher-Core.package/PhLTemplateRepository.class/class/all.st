as yet unclassified
all
	| groups |
	groups := OrderedCollection new.
	groups add: PhLRemoteJenkinsTemplateGroup inriaRmod.
	groups add: PhLRemoteLauncherTemplateGroup pharoOfficialGroup.
	^ self new
		setGroups: groups;
		yourself 