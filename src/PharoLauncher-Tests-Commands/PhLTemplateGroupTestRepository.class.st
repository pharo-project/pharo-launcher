"
TemplateGroupRepository used for test purposes.
I override the default location of templates.
"
Class {
	#name : #PhLTemplateGroupTestRepository,
	#superclass : #PhLTemplateGroupRepository,
	#instVars : [
		'fileSystem'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #initialization }
PhLTemplateGroupTestRepository >> initialize [ 
	super initialize.
	fileSystem := FileSystem memory.
]

{ #category : #accessing }
PhLTemplateGroupTestRepository >> localTemplatesGroup [
	^ PhLDownloadedTemplateGroup new 
		baseDirectory: fileSystem root
]

{ #category : #action }
PhLTemplateGroupTestRepository >> refresh [ 
	"NOOP"
]
