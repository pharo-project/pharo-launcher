"
A presenter for Pharo Launcher templates used for test purposes
"
Class {
	#name : #PhLTestTemplatesPresenter,
	#superclass : #PhLTemplatesPresenter,
	#instVars : [
		'request',
		'selection',
		'templates',
		'templatesGroup',
		'imageRepository'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #'user interaction' }
PhLTestTemplatesPresenter >> clickOnCreateButton [
	(descriptionPanel instVarNamed: 'createButton') click
]

{ #category : #configuring }
PhLTestTemplatesPresenter >> createLocalTemplateNamed: aName [
	| zipFile |
	zipFile := self localTemplatesGroup baseDirectory / (aName , '.zip').
	self localTemplatesGroup
		register: (PhLLocalTemplate name: aName zipFile: zipFile)
		withZip: zipFile.
	self newZipArchive: zipFile.
	self refresh.
]

{ #category : #configuring }
PhLTestTemplatesPresenter >> createRemoteTemplateNamed: aName [
	self remoteTemplatesGroup
		addTemplate: (PhLRemoteTemplate name: aName url: 'http://', aName, '.foo').
	self refresh.
]

{ #category : #'api - accessing' }
PhLTestTemplatesPresenter >> imageName [
	^ 'TestCreateImage'
]

{ #category : #'api - accessing' }
PhLTestTemplatesPresenter >> imageRepository [
	^ imageRepository ifNil: [ imageRepository := PhLDirectoryBasedImageRepository forDirectory: FileSystem memory root ]
	
]

{ #category : #initialization }
PhLTestTemplatesPresenter >> initialize [
	self model: (PhLTemplateGroupTestRepository new).
	self application: (PharoLauncherApplication new
		scriptsDirectory: FileSystem memory root;
		yourself).
	request := PhLTestRequest new.
	templates := OrderedCollection new.
	
	super initialize.
]

{ #category : #accessing }
PhLTestTemplatesPresenter >> localTemplatesGroup [
	^ self templateRepository localTemplatesGroup
]

{ #category : #'user interaction' }
PhLTestTemplatesPresenter >> newConfirmation [
	^ PhLTestConfirmation new
]

{ #category : #'user interaction' }
PhLTestTemplatesPresenter >> newRequest [
	^ request
]

{ #category : #private }
PhLTestTemplatesPresenter >> newZipArchive: aFileReference [
	| archive |
	archive := ZipArchive new.
	archive
		addDeflateString: 'foo' as: 'bar.image';
		addDeflateString: 'foo' as: 'bar.changes'.
	aFileReference
		binaryWriteStreamDo: [ :stream | archive writeTo: stream ].

]

{ #category : #accessing }
PhLTestTemplatesPresenter >> remoteTemplatesGroup [
	^ self templateRepository remoteTemplatesGroup
]

{ #category : #configuring }
PhLTestTemplatesPresenter >> requestAnswer: answer [
	request answer: answer
]

{ #category : #configuring }
PhLTestTemplatesPresenter >> selectInitializationScript: anIndex [
	descriptionPanel selectInitializationScript: anIndex
]

{ #category : #configuring }
PhLTestTemplatesPresenter >> selectLocalGroup [
	self selectCategory: 1
]

{ #category : #configuring }
PhLTestTemplatesPresenter >> selectRemoteGroup [
	self selectCategory: 2
]

{ #category : #configuring }
PhLTestTemplatesPresenter >> selectTemplateNamed: aTemplateName [
	templateTable selectItem: (self templates detect: [ :each | each name = aTemplateName ])

]

{ #category : #accessing }
PhLTestTemplatesPresenter >> templateNames [
	^ self templates collect: #name
]

{ #category : #accessing }
PhLTestTemplatesPresenter >> templateRoots [
	^ templateTable roots
]

{ #category : #accessing }
PhLTestTemplatesPresenter >> templates [
	^ self localTemplatesGroup templatesAndGroups asOrderedCollection, self remoteTemplatesGroup templatesAndGroups
]
