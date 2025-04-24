"
A memory store that has an identifier.
If 2 stores have the same identifier, it means they are equals (useful for testing).
"
Class {
	#name : 'IdentifiableMemoryStore',
	#superclass : 'MemoryStore',
	#instVars : [
		'identifier'
	],
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'instance creation' }
IdentifiableMemoryStore class >> named: aName [

	^ self new
		identifier: aName;
		yourself
]

{ #category : 'comparing' }
IdentifiableMemoryStore >> = other [

	^ self class = other class
		and: [ self identifier = other identifier ]
]

{ #category : 'comparing' }
IdentifiableMemoryStore >> hash [
		^ (self identifier hash bitXor: self identifier hash)
]

{ #category : 'comparing' }
IdentifiableMemoryStore >> identifier [

	^ identifier
]

{ #category : 'accessing' }
IdentifiableMemoryStore >> identifier: aSymbol [ 
	identifier := aSymbol
]
