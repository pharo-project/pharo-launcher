Class {
	#name : #PhLRelocateImageDirectoryCommand,
	#superclass : #PhLGeneralCommand,
	#instVars : [
		'source',
		'target'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #executing }
PhLRelocateImageDirectoryCommand >> canBeExecuted [
	self target ensureCreateDirectory.
	^ self source ~= self target 
		and: [ self source hasChildren 
		and: [ self target hasChildren not ] ]
]

{ #category : #executing }
PhLRelocateImageDirectoryCommand >> execute [
	self canBeExecuted
		ifTrue: [ 
			self relocate.
			self informMigrationDone ]
		ifFalse: [ self informManualMigrationNeeded ]
]

{ #category : #'user interaction' }
PhLRelocateImageDirectoryCommand >> informManualMigrationNeeded [
	self application newInformation
		message:
				('You need to manually relocate your images from {1} to {2}'
						format:
							{(self source pathString).
							(self target pathString)});
		inform
]

{ #category : #'user interaction' }
PhLRelocateImageDirectoryCommand >> informMigrationDone [
	self application newInformation
		message:
				('Migration of your images from {1} to {2} done'
						format:
							{(self source pathString).
							(self target pathString)});
		inform
]

{ #category : #executing }
PhLRelocateImageDirectoryCommand >> relocate [
	self source children do: [ :child | 
		child moveTo:
			(self target resolvePath: (child relativeTo: self source)) resolve ]
]

{ #category : #'user interaction' }
PhLRelocateImageDirectoryCommand >> requestTargetLocation [
	^ self application newRequest
		initialAnswer: self source;
		title: 'New location for your images';
		validateAnswer: [ :answer | answer asFileReference ~= self source ];
		request
]

{ #category : #accessing }
PhLRelocateImageDirectoryCommand >> source [
	^ source ifNil: [ source := PhLDirectoryBasedImageRepository location ]
]

{ #category : #accessing }
PhLRelocateImageDirectoryCommand >> source: aDirectory [
	source := aDirectory
]

{ #category : #accessing }
PhLRelocateImageDirectoryCommand >> target [
	^ target ifNil: [ target := self requestTargetLocation asFileReference ]
]

{ #category : #accessing }
PhLRelocateImageDirectoryCommand >> target: aDirectory [
	target := aDirectory
]
