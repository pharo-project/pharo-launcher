instance creation
all
	| groups |
	groups := OrderedCollection new.
	groups add: PhLJenkinsServer inriaRmod.
	groups add: PhLJenkinsServer inriaPharoContribution.
	groups add: PhLHTTPListingTemplateGroup pharo20.
	groups add: PhLHTTPListingTemplateGroup pharo30.
	groups add: PhLLocalTemplateGroup default.
	^ self new
		setGroups: groups;
		yourself