"
PhLStartupManager is in charge of running startup actions related to the PharoLauncher.
"
Class {
	#name : #PhLStartupManager,
	#superclass : #Object,
	#classVars : [
		'StartUpClasses'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #actions }
PhLStartupManager class >> addToLauncherStartUpList: aClass [
	(self startUpClasses includes: aClass)
		ifFalse: [ self startUpClasses add: aClass ]

]

{ #category : #'class initialization' }
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
PhLStartupManager class >> startUp [
	self startUpClasses do: [ :c | c ifNotNil: [ c launcherStartUp ] ]
]

{ #category : #accessing }
PhLStartupManager class >> startUpClasses [
	^ StartUpClasses
		ifNil: [ StartUpClasses := SortedCollection sortBlock: [ :c1 :c2 | c1 launcherStartUpPriority < c2 launcherStartUpPriority ] ]
]
