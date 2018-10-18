Class {
	#name : #PhLHTTPListingTemplateGroupTest,
	#superclass : #PhLAbstractTemplateGroupTest,
	#category : 'PharoLauncher-Tests-Functional'
}

{ #category : #coverage }
PhLHTTPListingTemplateGroupTest >> classToBeTested [
	^ PhLHTTPListingTemplateGroup
]

{ #category : #helpers }
PhLHTTPListingTemplateGroupTest >> exampleContent [
	^ '<html>
	<head></head><body>
	<a href="foo.html">foo.zip</a>
	<a href="bla1.zip">bla1.zip</a>
	... bla bla ...
	<a href="bla2.zip">bla2.zip</a>
	... bla bla ...
	</body>
	</html>'
]

{ #category : #helpers }
PhLHTTPListingTemplateGroupTest >> exampleUrl [
	^ 'http://foo.example.com/bar' asZnUrl
]

{ #category : #'instance-creation' }
PhLHTTPListingTemplateGroupTest >> newGroup [
	^ PhLHTTPListingTemplateGroup name: 'Test' url: self exampleUrl
]

{ #category : #running }
PhLHTTPListingTemplateGroupTest >> setUp [
	super setUp.
	self downloadManager atUrl: self exampleUrl answer: self exampleContent
]

{ #category : #tests }
PhLHTTPListingTemplateGroupTest >> testIsGroup [
	self assert: self newGroup isTemplateGroup
]

{ #category : #tests }
PhLHTTPListingTemplateGroupTest >> testTemplatesAndGroups [
	| group templatesAndGroups |
	group := self newGroup.
	templatesAndGroups := group templatesAndGroups.
	self assert: templatesAndGroups size equals: 2.	"<- 2 archive links in exampleContent"
	self assert: (templatesAndGroups noneSatisfy: [ :template | template isTemplateGroup ]).
	self assert: (templatesAndGroups collect: #name) asSet equals: #('bla1' 'bla2') asSet
]
