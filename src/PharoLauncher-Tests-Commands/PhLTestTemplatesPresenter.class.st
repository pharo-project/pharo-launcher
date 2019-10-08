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
		'imageRepository'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #configuring }
PhLTestTemplatesPresenter >> createTemplateNamed: aName [
	| zipFile |
	zipFile := (aName ,'.zip') asFileReference.
	templates add: (PhLLocalTemplate name: aName zipFile: zipFile).
	self newZipArchive: zipFile.
]

{ #category : #selecting }
PhLTestTemplatesPresenter >> hasSingleTemplateSelected [
	^ selection notNil and: [ selection size = 1 ]
]

{ #category : #'api -  accessing' }
PhLTestTemplatesPresenter >> imageName [
	^ 'TestCreateImage'
]

{ #category : #'api -  accessing' }
PhLTestTemplatesPresenter >> imageRepository [
	^ imageRepository ifNil: [ imageRepository := PhLDirectoryBasedImageRepository forDirectory: FileSystem memory root ]
	
]

{ #category : #initialization }
PhLTestTemplatesPresenter >> initialize [
	self model: (PhLTemplateGroupRepository default).
	self application: PharoLauncherApplication new.
	request := PhLTestRequest new.
	templates := OrderedCollection new.
	
	super initialize.
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

{ #category : #configuring }
PhLTestTemplatesPresenter >> selectionNames: aListOfTemplateNames [
	selection := templates select: [ :template | 
		aListOfTemplateNames includes: template name ].
]

{ #category : #selecting }
PhLTestTemplatesPresenter >> singleTemplate [
	self hasSingleTemplateSelected
		ifFalse: [ PhLCommandError  signal ].
	^ selection first "multiple selection enabled, always return a collection"
]
