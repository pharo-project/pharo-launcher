Class {
	#name : #PhLCreateTemplateFromImageTest,
	#superclass : #TestCase,
	#instVars : [
		'template'
	],
	#category : #'PharoLauncher-Tests-Debug'
}

{ #category : #accessing }
PhLCreateTemplateFromImageTest class >> defaultTimeLimit [
	^ 1 minute
]

{ #category : #running }
PhLCreateTemplateFromImageTest >> tearDown [
	template ifNotNil: [ template zipArchive ensureDelete ].
	super tearDown
]

{ #category : #tests }
PhLCreateTemplateFromImageTest >> testCanCreateATemplateFromImage [
	| image templateName templateRepository zipMemberNames fs fileNames |
	
	templateName := 'newTemplate'.
	fs := FileSystem memory root.
	fileNames := {'a.image' . 'a.changes' . PhLImage versionFileName . 'a-23456ef.sources'}.
	fileNames do: [ :fileName | (fs / fileName) ensureCreateFile ].
	image := PhLImage location: fs / fileNames first.
	templateRepository := PhLTemplateGroupRepository newFromGroups: { PhLDownloadedTemplateGroup named: 'cache group' }.
	
	templateRepository createLocalTemplateFrom: image named: templateName.
	
	self assert: (templateRepository hasLocalTemplateNamed: templateName).
	template := templateRepository localTemplateNamed:templateName.
	zipMemberNames := (ZipArchive new readFrom: template zipArchive) memberNames.
	self 
		assertCollection: zipMemberNames 
	 	hasSameElements: {templateName , '.image' . templateName , '.changes'} , (fileNames allButFirst: 2).
	
]
