Class {
	#name : #PhLCreateTemplateFromImageTest,
	#superclass : #TestCase,
	#instVars : [
		'template'
	],
	#category : #'PharoLauncher-Tests-Functional'
}

{ #category : #accessing }
PhLCreateTemplateFromImageTest class >> defaultTimeLimit [
	^ 1 minute
]

{ #category : #running }
PhLCreateTemplateFromImageTest >> tearDown [ 
	template ifNotNil: [ template zipArchive ensureDelete ]
]

{ #category : #tests }
PhLCreateTemplateFromImageTest >> testCanCreateATemplateFromImage [
	| image templateName templateRepository zipMemberNames |
	
	templateName := 'newTemplate'.
	image := PhLImage location: Smalltalk imageFile.
	templateRepository := PhLTemplateGroupRepository newFromGroups: { PhLDownloadedTemplateGroup named: 'cache group' }.
	
	templateRepository createLocalTemplateFrom: image named: templateName.
	
	self assert: (templateRepository hasLocalTemplateNamed: templateName).
	template := templateRepository localTemplateNamed:templateName.
	zipMemberNames := (ZipArchive new readFrom: template zipArchive) memberNames.
	self 
		assertCollection: zipMemberNames 
	 	hasSameElements: { templateName,'.image' . templateName,'.changes' . 'pharo.version' . Smalltalk image sourcesFile basename }.
	
]
