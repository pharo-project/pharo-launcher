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
		'remoteTemplatesGroup'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

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
PhLTemplateGroupTestRepository >> newLocalTemplatesGroup [
	^ PhLDownloadedTemplateGroup new 
		baseDirectory: fileSystem root;
		setName: 'Local test templates';
		yourself
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> newRemoteTemplatesGroup [
	^ PhLFixedURLsTemplateGroup new 
			setName: 'Remote test templates' Templates: OrderedCollection new;
			yourself
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> remoteTemplatesGroup [
	^ remoteTemplatesGroup
]
