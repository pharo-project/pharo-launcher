"
TemplateGroupRepository used for test purposes.
I override the default location of templates.
"
Class {
	#name : #PhLTemplateGroupTestRepository,
	#superclass : #PhLTemplateGroupRepository,
	#instVars : [
		'fileSystem',
		'localTemplateGroup',
		'remoteTemplatesGroup',
		'defaultTemplateGroup'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #creation }
PhLTemplateGroupTestRepository >> addTemplateCategoryNamed: aString [ 
	self shouldBeImplemented.
]

{ #category : #initialization }
PhLTemplateGroupTestRepository >> createLocalTemplateNamed: aName [
	| zipFile template |
	zipFile := self localTemplatesGroup baseDirectory / (aName , '.zip').
	template := PhLLocalTemplate name: aName zipFile: zipFile.
	self localTemplatesGroup register: template withZip: zipFile.
	self newZipArchive: zipFile.
	^ template
]

{ #category : #initialization }
PhLTemplateGroupTestRepository >> createRemoteTemplateNamed: aName [
	self remoteTemplatesGroup
		addTemplate: (PhLRemoteTemplate name: aName url: 'http://', aName, '.foo').
]

{ #category : #initialization }
PhLTemplateGroupTestRepository >> createTemplateInDefaultGroupNamed: aName [
	self remoteTemplatesGroup
		addTemplate: (PhLRemoteTemplate name: aName url: 'http://', aName, '.foo').
]

{ #category : #instance }
PhLTemplateGroupTestRepository >> createTemplateNamed: aName inCategory: aCategoryName [
	(self categoryNamed: aCategoryName) templatesAndGroups 
		add: (PhLRemoteTemplate name: aName url: 'http://', aName, '.foo').
]

{ #category : #initialization }
PhLTemplateGroupTestRepository >> initialize [ 
	super initialize.
	fileSystem := FileSystem memory.
	localTemplateGroup := self newLocalTemplatesGroup.
	remoteTemplatesGroup := self newRemoteTemplatesGroup.
	self setGroups: { localTemplateGroup . remoteTemplatesGroup }.
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> localTemplatesGroup [
	^ localTemplateGroup
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> localTemplatesGroupName [
	^ 'Local test templates'
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> newDefaultTemplatesGroup [
	^ PhLFixedURLsTemplateGroup new 
			setName: self defaultTemplatesGroup Templates: OrderedCollection new;
			yourself
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> newLocalTemplatesGroup [
	^ PhLDownloadedTemplateGroup new 
		baseDirectory: fileSystem root;
		setName: self localTemplatesGroupName;
		yourself
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> newRemoteTemplatesGroup [
	^ PhLFixedURLsTemplateGroup new 
			setName: 'Remote test templates' Templates: OrderedCollection new;
			yourself
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> newRemoteTemplatesGroupNamed: aGroupName [
	^ PhLFixedURLsTemplateGroup new 
			setName: aGroupName Templates: OrderedCollection new;
			yourself
]

{ #category : #initialization }
PhLTemplateGroupTestRepository >> newZipArchive: aFileReference [
	| archive |
	archive := ZipArchive new.
	archive
		addDeflateString: 'foo' as: 'bar.image';
		addDeflateString: 'foo' as: 'bar.changes'.
	aFileReference
		binaryWriteStreamDo: [ :stream | archive writeTo: stream ].
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> remoteTemplatesGroup [
	^ remoteTemplatesGroup
]
