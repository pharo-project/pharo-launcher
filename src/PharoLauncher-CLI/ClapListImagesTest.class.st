Class {
	#name : #ClapListImagesTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-CLI'
}

{ #category : #tests }
ClapListImagesTest >> testExecuteCommandWhenThereAreManyImagePrintsTheListOfImages [
	| command output repo |
	command := ClapListImages new.
   repo := PhLMockImageRepository new.
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListAnotherImagesItsNotAGoodMethod ].

	self assert: output equals: 'Pharo 8.0 - 64bit (stable)Pharblablao 8.0 - 64bit (stable)'
]

{ #category : #tests }
ClapListImagesTest >> testExecuteCommandWhenThereIsOneImagePrintsTheListOfImages [
	| command output repo |
	command := ClapListImages new.
   repo := PhLMockImageRepository new.

	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListImages ].

	self assert: output equals: 'Pharo 8.0 - 64bit (stable)'
]

{ #category : #tests }
ClapListImagesTest >> testExecuteCommandWhenThereIsOneImagePrintsTheListOfImagesAsSton [
	| command output repo |
	command := ClapListImages new.
   repo := PhLMockImageRepository new.

	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListImagesAsSton ].

	self assert: (STON fromString: output) equals: {PhLMockImageRepository new images first file} asOrderedCollection
]
