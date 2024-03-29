"
This is a mock object that simulates PhLCommand instances for testing command logic
"
Class {
	#name : #PhLCliCommandMock,
	#superclass : #PhLCliCommand,
	#instVars : [
		'rowMode',
		'briefPrint',
		'outputAsSton'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #'private - testing' }
PhLCliCommandMock class >> isProductionCommandClass [

	"this command class not exposed for user to be visible in CLI"
	^ false
]

{ #category : #accessing }
PhLCliCommandMock >> briefPrint [  
	
	^ briefPrint 
]

{ #category : #accessing }
PhLCliCommandMock >> briefPrint: aBool [
	
	briefPrint := aBool
]

{ #category : #initialization }
PhLCliCommandMock >> delimiter [

	^ self rowMode
		ifTrue: [ ': ' ]
		ifFalse: [ '*' ]
]

{ #category : #initialization }
PhLCliCommandMock >> initialize [ 
	
	self rowMode: false.
	self briefPrint: false.
	self outputAsSton: false.
	self resetOutStream 
]

{ #category : #accessing }
PhLCliCommandMock >> outputAsSton [  
	
	^ outputAsSton 
]

{ #category : #accessing }
PhLCliCommandMock >> outputAsSton: aBool [
	
	outputAsSton := aBool
]

{ #category : #initialization }
PhLCliCommandMock >> resetOutStream [

	outStream := String new writeStream.
	self cliFormatter ifNotNil: [:formatter |formatter outStream: outStream  ]
]

{ #category : #accessing }
PhLCliCommandMock >> rowMode [ 
	
	^ rowMode
]

{ #category : #accessing }
PhLCliCommandMock >> rowMode: aBool [
	
	rowMode := aBool
]
