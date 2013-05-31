instance creation
all
	| groups |
	groups := OrderedCollection new.
	groups add: PhLRemoteJenkinsTemplateGroup inriaRmod.
	groups add: PhLRemoteJenkinsTemplateGroup inriaPharo.
	groups add: PhLRemoteJenkinsTemplateGroup inriaPharoContribution.
	groups add: PhLHTTPListingTemplateGroup pharo30.
	groups add: PhLRemoteLauncherTemplateGroup pharoOfficialGroup.
	groups add: PhLLocalTemplateGroup default.
	^ self new
		setGroups: groups;
		yourself