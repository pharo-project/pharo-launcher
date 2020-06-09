"
I'm an extension of STONWriter allowing to map instance variables of an object before its serialization.
"
Class {
	#name : #STONWriterWithMapping,
	#superclass : #STONWriter,
	#category : #'PharoLauncher-STON-extension'
}

{ #category : #writing }
STONWriterWithMapping >> writeObject: anObject [
	| instanceVariableNames |
	(instanceVariableNames := anObject class stonAllInstVarNames) isEmpty
		ifTrue: [ 
			self writeObject: anObject do: [ self encodeMap: #() ] ]
		ifFalse: [ 
			self writeObject: anObject streamMap: [ :dictionary | | mappings |
				mappings := anObject stonOnMapping asDictionary.
				instanceVariableNames do: [ :each | | value |
					value := anObject instVarNamed: each.
					mappings at: each ifPresent: [ :mapping | value := mapping value: value ].
					value
						ifNotNil: [ dictionary at: each asSymbol put: value ]
						ifNil: [ 
							anObject stonShouldWriteNilInstVars 
								ifTrue: [ dictionary at: each asSymbol put: nil ] ] ] ] ]
]
