"
PhLStartupManager is in charge of running startup actions related to the PharoLauncher.
"
Class {
	#name : #PhLStartupManager,
	#superclass : #Object,
	#classVars : [
		'StartUpClasses'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #actions }
PhLStartupManager class >> addToLauncherStartUpList: aClass [

	(self startUpClasses includes: aClass)
		ifFalse: [ self startUpClasses add: aClass ]

]

{ #category : #initialization }
PhLStartupManager class >> initialize [

	SessionManager default registerToolClassNamed: self name
]

{ #category : #actions }
PhLStartupManager class >> removeFromStartupList: aClass [
	self startUpClasses remove: aClass
]

{ #category : #actions }
PhLStartupManager class >> resetStartUpClasses [
	StartUpClasses := nil
]

{ #category : #'system startup' }
PhLStartupManager class >> startUp: isANewSession [

	isANewSession ifFalse: [ ^ self ].
	
	PharoLauncherApplication reset.
	self startUpClasses do: [ :c | c ifNotNil: [ c launcherStartUp ] ]
]

{ #category : #accessing }
PhLStartupManager class >> startUpClasses [

	^ StartUpClasses ifNil: [ 
		StartUpClasses := SortedCollection sortBlock: #launcherStartUpPriority ascending ]
]
