"
I maintain a collection of PhLTemplateGroup. I take care of adding a cache to each group.
"
Class {
	#name : #PhLTemplateGroupRepository,
	#superclass : #PhLRepository,
	#instVars : [
		'groupCaches'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLTemplateGroupRepository class >> newFromGroups: aCollection [
	^ self new
		setGroups: aCollection;
		yourself
]

{ #category : #private }
PhLTemplateGroupRepository >> addGroup: aGroup [
	| cache |
	cache := PhLCacheTemplateGroup group: aGroup. "wrap all groups inside a cache."
	groupCaches addLast: cache.
]

{ #category : #action }
PhLTemplateGroupRepository >> createLocalTemplateFrom: anImage named: aString [
	(self hasLocalTemplateNamed: aString)
		ifTrue: [ PhLError signal: 'A local template with the same name already exists' ].
	self createZipArchiveFrom: anImage named: aString.
	self createLocalTemplateNamed: aString.
	self refresh
]

{ #category : #action }
PhLTemplateGroupRepository >> createLocalTemplateNamed: aString [
	| localTemplate |
	localTemplate := PhLLocalTemplate name: aString zipFile: PhLDownloadedTemplateGroup default baseDirectory / aString , 'zip'.
	PhLDownloadedTemplateGroup default register: localTemplate withZip: localTemplate zipArchive
]

{ #category : #action }
PhLTemplateGroupRepository >> createZipArchiveFrom: anImage named: aString [
	| archive |
	archive := ZipArchive new.
	archive
		addFile: anImage imageFile fullName as: aString , '.image';
		addFile: anImage changesFile fullName as: aString , '.changes'.
	[ archive addFile: anImage sourcesFile fullName as: anImage sourcesFile basename ]
		on: NotFound 
		do: [ :e | "ignore the file" ].
	anImage versionFile exists
		ifTrue: [ archive addFile: anImage versionFile fullName as: anImage versionFile basename ].
	archive writeToFileNamed: (PhLDownloadedTemplateGroup default baseDirectory / aString , 'zip') fullName
]

{ #category : #action }
PhLTemplateGroupRepository >> deleteTemplate: aTemplate [ 
	aTemplate zipArchive delete.
	self refresh.
]

{ #category : #action }
PhLTemplateGroupRepository >> deleteTemplates: someTemplates [ 
	self dontNotifyDuring: [ someTemplates do: [ :template | self deleteTemplate: template ] ].
	self refresh
]

{ #category : #testing }
PhLTemplateGroupRepository >> hasLocalTemplateNamed: aString [
	^ PhLDownloadedTemplateGroup default templatesAndGroups 
		anySatisfy: [ :each | each name = aString ]
]

{ #category : #accessing }
PhLTemplateGroupRepository >> localTemplateNamed: aString [
	^ PhLDownloadedTemplateGroup default templatesAndGroups 
		detect: [ :each | each name = aString ]
]

{ #category : #action }
PhLTemplateGroupRepository >> makeUniqueTemplateName: aString [
	|  localTemplateNames |
	localTemplateNames := PhLDownloadedTemplateGroup default templatesAndGroups collect: [ :each | each name ].
	^ self makeUniqueTemplateName: aString among: localTemplateNames
]

{ #category : #action }
PhLTemplateGroupRepository >> makeUniqueTemplateName: baseTemplateName among: existingTemplateNames [
	"Provide a reasonable default template name using the next incremental count for images with similar basenames"

	"See #testMakeUniqueImageName for samples"

	^ self makeUniqueName: baseTemplateName among: existingTemplateNames
]

{ #category : #action }
PhLTemplateGroupRepository >> refresh [
	groupCaches do: #refresh.
	self contentsChanged.
]

{ #category : #accessing }
PhLTemplateGroupRepository >> roots [
	^ groupCaches
]

{ #category : #'initialize-release' }
PhLTemplateGroupRepository >> setGroups: aCollection [
	| names |
	names := Set new.
	groupCaches := OrderedCollection new.
	aCollection
		do: [ :group | 
			(names includes: group name)
				ifTrue: [ PhLError signal: '2 groups must not have the same name' ]
				ifFalse: [ self addGroup: group ] ]
]
