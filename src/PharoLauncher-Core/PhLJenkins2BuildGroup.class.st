"
I  represent a named group of builds for a Jenkins job.
By example, I'm used to offer a group 'All builds' provinding a list of all builds of a particualr job.
"
Class {
	#name : #PhLJenkins2BuildGroup,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'builds',
		'name'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLJenkins2BuildGroup class >> name: aString builds: aCollection [ 
	^ self new
		setName: aString builds: aCollection;
		yourself
]

{ #category : #accessing }
PhLJenkins2BuildGroup >> builds [
	^ builds
]

{ #category : #accessing }
PhLJenkins2BuildGroup >> name [
	^ name
]

{ #category : #initialization }
PhLJenkins2BuildGroup >> setName: aString builds: aCollection [ 
	name := aString.
	builds := aCollection
]

{ #category : #accessing }
PhLJenkins2BuildGroup >> templatesAndGroups [
	^ self builds sorted: [ :b1 :b2 | b1 number > b2 number ]
]
