"
Relocate the directory where the images are saved to another directory
"
Class {
	#name : #PhLRelocateImageDirectoryCommand,
	#superclass : #PhLGeneralCommand,
	#instVars : [
		'source',
		'target'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #action }
PhLRelocateImageDirectoryCommand >> execute [
	self source children collect: [ :child | child moveTo: (self target resolvePath: (child relativeTo: self source)) resolve ] 
]

{ #category : #action }
PhLRelocateImageDirectoryCommand >> executeOrInform [
	self isApplicable
		ifTrue: [ 
			self execute.
			self informMigrationDone ]
		ifFalse: [ self informManualMigrationNeeded ]
]

{ #category : #'user interaction' }
PhLRelocateImageDirectoryCommand >> informManualMigrationNeeded [
	PhLUIInformation new
		message:
				('You need to manually relocate your images from {1} to {2}'
						format:
							{(self source pathString).
							(self target pathString)});
		inform
]

{ #category : #'user interaction' }
PhLRelocateImageDirectoryCommand >> informMigrationDone [
	PhLUIInformation new
		message:
				('Migration of your images from {1} to {2} done'
						format:
							{(self source pathString).
							(self target pathString)});
		inform
]

{ #category : #testing }
PhLRelocateImageDirectoryCommand >> isApplicable [
	self target ensureCreateDirectory.
	^ self source ~= self target and: [ self source hasChildren and: [ self target hasChildren not ] ]
]

{ #category : #'user interaction' }
PhLRelocateImageDirectoryCommand >> requestTargetLocation [
	^ PhLUIRequest new
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
