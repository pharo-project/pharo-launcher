"
TemplateGroupRepository used for test purposes.
I override the default location of templates.
"
Class {
	#name : #PhLTemplateTestRepository,
	#superclass : #PhLTemplateGroupRepository,
	#instVars : [
		'fileSystem',
		'localTemplateGroup',
		'remoteTemplatesGroup'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #initialization }
PhLTemplateTestRepository >> createLocalTemplateNamed: aName [
	| zipFile template |
	zipFile := self localTemplatesGroup baseDirectory / (aName , '.zip').
	template := PhLLocalTemplate name: aName zipFile: zipFile.
	self localTemplatesGroup register: template withZip: zipFile.
	self newZipArchive: zipFile.
	^ template
]

{ #category : #initialization }
PhLTemplateTestRepository >> createRemoteTemplateNamed: aName [
	self remoteTemplatesGroup
		addTemplate: (PhLRemoteTemplate name: aName url: 'http://', aName, '.foo').
]

{ #category : #initialization }
PhLTemplateTestRepository >> createTemplateInDefaultGroupNamed: aName [
	self remoteTemplatesGroup
		addTemplate: (PhLRemoteTemplate name: aName url: 'http://', aName, '.foo').
]

{ #category : #instance }
PhLTemplateTestRepository >> createTemplateNamed: aName inCategory: aCategoryName [
	(self categoryNamed: aCategoryName) templatesAndGroups 
		add: (PhLRemoteTemplate name: aName url: ('http://', aName, '.foo') asZnUrl).
]

{ #category : #initialization }
PhLTemplateTestRepository >> initialize [ 
	super initialize.
	fileSystem := FileSystem memory.
	localTemplateGroup := self newLocalTemplatesGroup.
	remoteTemplatesGroup := self newRemoteTemplatesGroup.
	self setGroups: { localTemplateGroup . remoteTemplatesGroup }.
]

{ #category : #accessing }
PhLTemplateTestRepository >> localTemplatesGroup [
	^ localTemplateGroup
]

{ #category : #accessing }
PhLTemplateTestRepository >> localTemplatesGroupName [
	^ 'Local test templates'
]

{ #category : #accessing }
PhLTemplateTestRepository >> newDefaultTemplatesGroup [
	^ PhLFixedURLsTemplateGroup new 
			setName: self defaultTemplatesGroup Templates: OrderedCollection new;
			yourself
]

{ #category : #accessing }
PhLTemplateTestRepository >> newLocalTemplatesGroup [
	^ PhLDownloadedTemplateGroup new 
		baseDirectory: fileSystem root;
		setName: self localTemplatesGroupName;
		yourself
]

{ #category : #accessing }
PhLTemplateTestRepository >> newRemoteTemplatesGroup [
	^ PhLFixedURLsTemplateGroup new 
			setName: 'Remote test templates' Templates: OrderedCollection new;
			yourself
]

{ #category : #accessing }
PhLTemplateTestRepository >> newRemoteTemplatesGroupNamed: aGroupName [
	^ PhLFixedURLsTemplateGroup new 
			setName: aGroupName Templates: OrderedCollection new;
			yourself
]

{ #category : #initialization }
PhLTemplateTestRepository >> newZipArchive: aFileReference [
	| archive |
	archive := ZipArchive new.
	archive
		addDeflateString: 'foo' as: 'bar.image';
		addDeflateString: 'foo' as: 'bar.changes'.
	aFileReference
		binaryWriteStreamDo: [ :stream | archive writeTo: stream ].
]

{ #category : #accessing }
PhLTemplateTestRepository >> remoteTemplatesGroup [
	^ remoteTemplatesGroup
]
