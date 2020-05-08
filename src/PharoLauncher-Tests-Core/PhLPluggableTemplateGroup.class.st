"
I'm a kind of template group that is completely defined by my instance variables. Useful for testing.
"
Class {
	#name : #PhLPluggableTemplateGroup,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'name',
		'groups',
		'templates'
	],
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #'instance creation' }
PhLPluggableTemplateGroup class >> name: aString [
	^ self name: aString templates: #() groups: #()
]

{ #category : #'instance creation' }
PhLPluggableTemplateGroup class >> name: aString groups: anotherCollection [
	^ self new
		setName: aString templates: #() groups: anotherCollection;
		yourself
]

{ #category : #'instance creation' }
PhLPluggableTemplateGroup class >> name: aString templates: aCollection [
	^ self name: aString templates: aCollection groups: #()
]

{ #category : #'instance creation' }
PhLPluggableTemplateGroup class >> name: aString templates: aCollection groups: anotherCollection [
	^ self new
		setName: aString templates: aCollection groups: anotherCollection;
		yourself
]

{ #category : #accessing }
PhLPluggableTemplateGroup >> groups [
	^ groups
]

{ #category : #accessing }
PhLPluggableTemplateGroup >> name [
	^ name
]

{ #category : #initialization }
PhLPluggableTemplateGroup >> setName: aString templates: aCollection groups: anotherCollection [
	name := aString.
	templates := aCollection.
	groups := anotherCollection.
]

{ #category : #accessing }
PhLPluggableTemplateGroup >> templates [
	^ templates
]

{ #category : #accessing }
PhLPluggableTemplateGroup >> templatesAndGroups [
	^ self templates, self groups
]
