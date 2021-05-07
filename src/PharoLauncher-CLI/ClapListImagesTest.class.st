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
   repo images: OrderedCollection new.
   repo images add: (PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference).
   repo images add: (PhLImage location: 'asdsadaasdsad/Pharoblabla' asFileReference).
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListImages ].
   self assert: output equals: 'Pharo 8.0 - 64bit (stable)
Pharoblabla
'.
]

{ #category : #tests }
ClapListImagesTest >> testExecuteCommandWhenThereIsOneImagePrintsTheListOfImages [
	| command output repo |
	command := ClapListImages new.
   repo := PhLMockImageRepository new.
   repo images: {PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference}.
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListImages ].
   self assert: output equals: 'Pharo 8.0 - 64bit (stable)
'.
]

{ #category : #tests }
ClapListImagesTest >> testExecuteCommandWhenThereIsOneImagePrintsTheListOfImagesAsSton [
	| command output repo |
	command := ClapListImages new.
   repo := PhLMockImageRepository new.
   repo images: OrderedCollection new.
   repo images add: (PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference).
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListImagesAsSton ].

	self assert: (STON fromString: output) equals: {repo images first file} asOrderedCollection.
]
