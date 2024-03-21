"
Give me unit tests and I will make sure they are run for all subclasses of PhLAbstractTemplateGroup
"
Class {
	#name : #PhLAbstractTemplateGroupTest,
	#superclass : #ClassTestCase,
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #testing }
PhLAbstractTemplateGroupTest class >> isAbstract [
	^ self name = 'PhLAbstractTemplateGroupTest'
]

{ #category : #helpers }
PhLAbstractTemplateGroupTest >> downloadManager [
	^ PhLDownloadManager default
]

{ #category : #'instance creation' }
PhLAbstractTemplateGroupTest >> newGroup [
	^ self subclassResponsibility
]

{ #category : #running }
PhLAbstractTemplateGroupTest >> setUp [
	super setUp.
	PhLDownloadManagerMock install
]

{ #category : #running }
PhLAbstractTemplateGroupTest >> tearDown [
	PhLDownloadManagerMock remove.
	super tearDown
]

{ #category : #tests }
PhLAbstractTemplateGroupTest >> testTemplatesAndGroupsIsACollection [
	| group templateAndGroups |
	group := self newGroup.
	templateAndGroups := group templatesAndGroups.
	self assert: templateAndGroups isCollection.
	self assert: templateAndGroups size > 0.
	group templatesAndGroups
		do: [ :templateOrGroup | templateOrGroup isTemplateGroup	"we just make sure the message can be sent without checking its result" ]
]
