"
This is mock object that simulates PhLCommand instances for testing command logic
"
Class {
	#name : #PhLCliCommandMock,
	#superclass : #PhLCliCommand,
	#instVars : [
		'rowMode',
		'briefPrint'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

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
	self resetOutStream
]

{ #category : #initialization }
PhLCliCommandMock >> resetOutStream [

	outStream := String new writeStream
]

{ #category : #accessing }
PhLCliCommandMock >> rowMode [ 
	
	^ rowMode
]

{ #category : #accessing }
PhLCliCommandMock >> rowMode: aBool [
	
	rowMode := aBool
]
