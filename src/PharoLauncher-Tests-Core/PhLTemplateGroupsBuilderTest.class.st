Class {
	#name : #PhLTemplateGroupsBuilderTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #tests }
PhLTemplateGroupsBuilderTest >> testCanBuildListWhenNoSourceTemplate [
	| list sources |
	sources := PhLTemplateSources withTemplateList: #().
	
	list := PhLTemplateGroupsBuilder buildFrom: sources.
	
	self 
		assert: list size 
		equals: 0
]

{ #category : #tests }
PhLTemplateGroupsBuilderTest >> testCanBuildListWithFixedUrlGroup [
	| groups group sources |
	sources := PhLTemplateSources withTemplateList: { PhLTemplateSource officialDistributionsGroup }.
	
	groups := PhLTemplateGroupsBuilder buildFrom: sources.
	
	self 
		assert: groups size
		equals: 1.
	group := groups anyOne.
	
	self assert: group isTemplateGroup.
	self 
		assert: group class
		equals: PhLFixedURLsTemplateGroup
]

{ #category : #tests }
PhLTemplateGroupsBuilderTest >> testCanBuildListWithFixedUrlTemplate [
	| groups group sources |
	
	group := PhLTemplateSource officialDistributionsGroup.
	group templates: { PhLTemplateSource pharo70x64 }.
	sources := PhLTemplateSources withTemplateList: { group }.

	groups := PhLTemplateGroupsBuilder buildFrom: sources.
	
	self 
		assert: groups size
		equals: 1.
	group := groups anyOne.
	
	self assert: group templatesAndGroups size
		equals: 1.
	self assert: group templatesAndGroups first class
		equals: PhLRemoteTemplate.
]

{ #category : #tests }
PhLTemplateGroupsBuilderTest >> testCanBuildListWithHttpListingGroup [
	| groups group sources |
	sources := PhLTemplateSources withTemplateList: { PhLTemplateSource pharo70 }.
	
	groups := PhLTemplateGroupsBuilder buildFrom: sources.
	
	self 
		assert: groups size
		equals: 1.
	group := groups anyOne.
	
	self assert: group isTemplateGroup.
	self 
		assert: group class
		equals: PhLHTTPListingTemplateGroup
]

{ #category : #tests }
PhLTemplateGroupsBuilderTest >> testCanBuildListWithJenkinsGroup [
	| groups group sources |
	sources := PhLTemplateSources withTemplateList: { PhLTemplateSource inriaPharoContribution }.
		
	groups := PhLTemplateGroupsBuilder buildFrom: sources.
	
	self 
		assert: groups size
		equals: 1.
	group := groups anyOne.
	
	self assert: group isTemplateGroup.
	self 
		assert: group class
		equals: PhLJenkins2Server
]
