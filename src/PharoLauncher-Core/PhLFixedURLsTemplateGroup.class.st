"
Represent a list of templates that is defined at construction time. The interesting property of this group is that is does not require the network to be shown. The network is only needed to actually download a template.
"
Class {
	#name : #PhLFixedURLsTemplateGroup,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'templates',
		'name'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #adding }
PhLFixedURLsTemplateGroup >> addTemplate: aTemplate [
	templates add: aTemplate
]

{ #category : #accessing }
PhLFixedURLsTemplateGroup >> name [
	^ name
]

{ #category : #initialization }
PhLFixedURLsTemplateGroup >> setName: aString Templates: aCollection [
	name := aString.
	templates := aCollection
]

{ #category : #accessing }
PhLFixedURLsTemplateGroup >> templatesAndGroups [
	^ templates
]
