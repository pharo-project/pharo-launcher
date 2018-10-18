"
I'm the abstract superclass of all commands. I implement the command pattern. My main entry methods are #execute and #isApplicable.

I rely on the existence of a context (instance of PhLCommandContext) to query and change my environment.
"
Class {
	#name : #PhLCommand,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLCommand class >> allConcreteCommands [
	^ (self allSubclasses reject: #isAbstract) 
		sort: [ :c1 :c2 | 
			(c1 group = c2 group)
				ifTrue: [ c1 positionInGroup < c2 positionInGroup ]
				ifFalse: [ c1 group < c2 group ] ]
]

{ #category : #'instance creation' }
PhLCommand class >> allConcreteCommandsOn: aContext [
	^ self allConcreteCommands collect: [ :cls | cls on: aContext ]
]

{ #category : #accessing }
PhLCommand class >> group [
	^ 2
]

{ #category : #accessing }
PhLCommand class >> icon [
	^ self iconNamed: #blankIcon
]

{ #category : #testing }
PhLCommand class >> isAbstract [
	^ self name = 'PhLCommand'
]

{ #category : #'instance creation' }
PhLCommand class >> on: aPharoLauncherModel [
	^ self new
		setModel: aPharoLauncherModel;
		yourself
]

{ #category : #accessing }
PhLCommand class >> positionInGroup [
	^ 1 
]

{ #category : #accessing }
PhLCommand class >> title [
	^ self subclassResponsibility
]

{ #category : #private }
PhLCommand >> ensure: aBoolean [
	aBoolean ifFalse: [ PhLCommandError signal ]
]

{ #category : #action }
PhLCommand >> execute [
	self subclassResponsibility
]

{ #category : #action }
PhLCommand >> executeCommand [
	[ self execute ]
		on: PhLCommandCancellation
		do: [ :ex | "Do nothing - user has cancelled the command" ].
]

{ #category : #action }
PhLCommand >> executeIfApplicable [
	self isApplicable ifTrue: [ 
		self validateModelIntegrity ifTrue: [self executeCommand ]]
]

{ #category : #accessing }
PhLCommand >> group [
	^ self class group
]

{ #category : #accessing }
PhLCommand >> icon [
	^ self class icon
]

{ #category : #testing }
PhLCommand >> isApplicable [
	^ true
]

{ #category : #private }
PhLCommand >> isEmptyOrNil [
	self shouldBeImplemented.
]

{ #category : #accessing }
PhLCommand >> model [

	^ model
]

{ #category : #'initialize - release' }
PhLCommand >> setModel: aPharoLauncherModel [
	model := aPharoLauncherModel
]

{ #category : #accessing }
PhLCommand >> title [
	^ self class title
]

{ #category : #action }
PhLCommand >> validateModelIntegrity [
	"noop - override if model can lose it's integrity"
	
	^true
]
