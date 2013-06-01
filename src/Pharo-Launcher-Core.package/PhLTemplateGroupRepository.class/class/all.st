instance creation
all
	| groups |
	groups := OrderedCollection new.
	groups add: PhLRemoteJenkinsTemplateGroup inriaRmod.
	groups add: PhLRemoteJenkinsTemplateGroup inriaPharoContribution.
	groups add: PhLHTTPListingTemplateGroup pharo30.
	groups add: PhLLocalTemplateGroup default.
	^ self new
		setGroups: groups;
		yourself