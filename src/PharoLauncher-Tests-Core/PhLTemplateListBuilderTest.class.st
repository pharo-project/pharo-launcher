Class {
	#name : #PhLTemplateListBuilderTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #tests }
PhLTemplateListBuilderTest >> testCanBuildListWhenNoSourceTemplate [
	| list |
	list := PhLTemplateGroupsBuilder buildFrom: OrderedDictionary new.
	
	self 
		assert: list size 
		equals: 0
]

{ #category : #tests }
PhLTemplateListBuilderTest >> testCanBuildListWithFixedUrlGroup [
	| groups group |
	groups := PhLTemplateGroupsBuilder buildFrom: { PhLTemplateSource officialDistributionsGroup }.
	
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
PhLTemplateListBuilderTest >> testCanBuildListWithFixedUrlTemplate [
	| groups group |
	
	group := PhLTemplateSource officialDistributionsGroup.
	group templates: { PhLTemplateSource pharo70x64 }.
	groups := PhLTemplateGroupsBuilder buildFrom: { group }.
	
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
PhLTemplateListBuilderTest >> testCanBuildListWithHttpListingGroup [
	| groups group |
	groups := PhLTemplateGroupsBuilder buildFrom: { PhLTemplateSource pharo70 }.
	
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
PhLTemplateListBuilderTest >> testCanBuildListWithJenkinsGroup [
	| groups group |
	groups := PhLTemplateGroupsBuilder buildFrom: { PhLTemplateSource inriaPharoContribution }.
	
	self 
		assert: groups size
		equals: 1.
	group := groups anyOne.
	
	self assert: group isTemplateGroup.
	self 
		assert: group class
		equals: PhLJenkins2Server
]
