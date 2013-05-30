as yet unclassified
all
	| groups |
	groups := OrderedCollection new.
	groups add: PhLRemoteJenkinsTemplateGroup inriaRmod.
	groups add: PhLRemoteJenkinsTemplateGroup inriaPharo.
	groups add: PhLRemoteJenkinsTemplateGroup inriaPharoContribution.
	groups add: PhLHTTPListingTemplateGroup pharo30.
	groups add: PhLRemoteLauncherTemplateGroup pharoOfficialGroup.
	^ self new
		setGroups: groups;
		yourself