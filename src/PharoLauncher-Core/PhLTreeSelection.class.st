"
A container for holding nodes selected in a tree, as well as being able to render a full pathName for each selection.


"
Class {
	#name : #PhLTreeSelection,
	#superclass : #Object,
	#instVars : [
		'selections'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLTreeSelection class >> with: aCollection [
	^self new 
		selections: aCollection;
		yourself
]

{ #category : #accessing }
PhLTreeSelection >> anyOne [
	^self leafNodes anyOne
]

{ #category : #accessing }
PhLTreeSelection >> anySatisfy: aBlockOrSymbol [
	^ self leafNodes anySatisfy: aBlockOrSymbol
]

{ #category : #accessing }
PhLTreeSelection >> leafNodes [
	^ self selections collect: [ :each | each content]
]

{ #category : #private }
PhLTreeSelection >> pathFor: treeNodeModel on: collection [
	| content |
	treeNodeModel parentNode ifNotNil: [ :node | self pathFor: node on: collection ].
	content := treeNodeModel content.
	collection
		add:
			(content isString
				ifTrue: [ content printString ]
				ifFalse: [ content name ])
]

{ #category : #private }
PhLTreeSelection >> pathNameFor: treeNodeModel on: writeStream [
	| content |
	treeNodeModel parentNode
		ifNotNil: [ :node | 
			self pathNameFor: node on: writeStream.
			writeStream nextPut: $- ].
	content := treeNodeModel content.
	writeStream
		nextPutAll:
			(content isString
				ifTrue: [ content printString ]
				ifFalse: [ content name ])
]

{ #category : #accessing }
PhLTreeSelection >> pathNames [
	^ self selections collect: [ :path | 
			| result |
			result := WriteStream on: String new.
			
			self pathNameFor: path on: result.
			
			result contents asFileName ]
		
]

{ #category : #accessing }
PhLTreeSelection >> pathes [
	^ self selections collect: [ :path | 
			| result |
			result := OrderedCollection new: 5.
			self pathFor: path on: result.
			result ]
		
]

{ #category : #accessing }
PhLTreeSelection >> select: aBlockOrSymbol [
	^self leafNodes select: aBlockOrSymbol
]

{ #category : #accessing }
PhLTreeSelection >> selections [
	^ selections
]

{ #category : #accessing }
PhLTreeSelection >> selections: anObject [
	selections := anObject
]

{ #category : #accessing }
PhLTreeSelection >> size [ 
	^self selections size
]
