"
I'm a job as can be available on a Jenkins platform.
"
Class {
	#name : #PhLJenkins2Job,
	#superclass : #PhLJenkins2Entity,
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #protected }
PhLJenkins2Job class >> jsonFields [
	^ {'name'.
	'url'.
	('lastSuccessfulBuild[' , PhLJenkins2Build jsonFieldsQuery , ']')}
]

{ #category : #protected }
PhLJenkins2Job class >> jsonName [
	^ 'jobs'
]

{ #category : #accessing }
PhLJenkins2Job >> builds [
	"Pipelines define jobs whereas standard jobs define builds"
	^ (self query: PhLJenkins2Build)
		ifEmpty: [ self query: PhLJenkins2Job ]
]

{ #category : #accessing }
PhLJenkins2Job >> lastSuccessfulBuild [
	^ (PhLJenkins2Build
		newWithProperties:
			(Dictionary new
				at: 'number' put: self lastSuccessfulBuildNumber;
				at: 'url' put: (self url / 'lastSuccessfulBuild') printString;
				yourself))
		parent: self;
		yourself
]

{ #category : #accessing }
PhLJenkins2Job >> lastSuccessfulBuildNumber [
	^ properties at: 'lastSuccessfulBuild'
		ifPresent: [ :dict | dict ifNil: [nil] ifNotNil: [dict at: 'number' ifPresent: [:num | num ] ifAbsent: [ nil ] ]]
		ifAbsent: [ nil ]
]

{ #category : #accessing }
PhLJenkins2Job >> name [
	^ properties at: 'name'
]

{ #category : #accessing }
PhLJenkins2Job >> templatesAndGroups [
	| builds |
	builds := self builds.
	self lastSuccessfulBuildNumber ifNil: [ ^ builds ].
	^ {(self lastSuccessfulBuild).
	(PhLJenkins2BuildGroup name: 'All builds' builds: builds)}
]
