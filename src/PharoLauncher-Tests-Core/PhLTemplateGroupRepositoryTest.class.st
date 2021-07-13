"
A PhLTemplateGroupRepositoryTest is a test class for testing the behavior of PhLTemplateGroupRepository
"
Class {
	#name : #PhLTemplateGroupRepositoryTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #tests }
PhLTemplateGroupRepositoryTest >> testCategoryNamedWithExistingCategoryShouldReturnCategory [
	| repository templateCategory |
	repository := PhLTemplateTestRepository new.
	
	templateCategory := repository categoryNamed: 'Remote test templates'.
	
	self assert: templateCategory equals: repository remoteTemplatesGroup 	
]

{ #category : #tests }
PhLTemplateGroupRepositoryTest >> testCategoryNamedWithNonExistingCategoryShouldRaiseNotFound [
	| repository |
	repository := PhLTemplateTestRepository new.
	
	self
		should: [ repository categoryNamed: 'non existing category' ]
		raise: NotFound
]

{ #category : #tests }
PhLTemplateGroupRepositoryTest >> testTemplateNamedWithExistingTemplateAndCategoryShouldReturnTemplate [
	| repository template foundTemplate|
	repository := PhLTemplateTestRepository new.
	template := repository createLocalTemplateNamed: 'testTemplate'.
	
	foundTemplate := repository templateNamed: template name inCategoryNamed: repository localTemplatesGroupName. 
	
	self assert: foundTemplate equals: template
]

{ #category : #tests }
PhLTemplateGroupRepositoryTest >> testTemplateNamedWithNonExistingCategoryShouldRaiseNotFound [
	| repository template |
	repository := PhLTemplateTestRepository new.
	template := repository createLocalTemplateNamed: 'testTemplate'.
	
	self
		should: [ repository templateNamed: template name inCategoryNamed: 'non existing category' ]
		raise: NotFound
]

{ #category : #tests }
PhLTemplateGroupRepositoryTest >> testTemplateNamedWithNonExistingTemplateShouldRaiseNotFound [
	| repository |
	repository := PhLTemplateTestRepository new.
	
	self
		should: [ repository templateNamed: 'templateNamed' inCategoryNamed: repository localTemplatesGroupName ]
		raise: NotFound
]
