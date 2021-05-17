"
testFindImage
	| repo command test1 test2 test3 |
	repo := PhLImagesMockRepo new.
	repo images: OrderedCollection new.
	command :=PhLImagesClapCommand new.
	command repository: repo.
	test1 := PhLImagesMockRepo  new.
	test2 := PhLImagesMockRepo new.
	test3 := PhLImagesMockRepo new.
	test1 name: 'ljflkdjbf.image'.
	test2 name: 'mytestimage.image'.
	test3 name: 'blabla.image'.
	repo add: test1.
	repo add: test2.
	repo add: test3.
	command findImage:'mytestimage.image'
"
Class {
	#name : #PhLImagesClapCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'stream'
	],
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #tests }
PhLImagesClapCommandTest >> testCopyImage [

	| repo command test1 test2 test3 |
	
	repo := PhLImagesMockRepo new.
	command := PhLImagesClapCommand new.
	command repository: repo.
	test1 := PhLImagesMock name: 'ljflkdjbf.image'.
	test2 := PhLImagesMock name: 'mytestimage.image'.
	test3 := PhLImagesMock name: 'blabla.image'.
	
	repo 
		add: test1;
		add: test2;
		add: test3.
				
	command outputCopyImage: 'mytestimage.image' to: 'mytestimagecopy.image'.
	
	self assert: repo images size equals: 4.
	
]

{ #category : #tests }
PhLImagesClapCommandTest >> testCopyImagesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'images'].
	command := command subcommands detect:[ :f | f canonicalName ='copy'].
	self assert: command flags size equals:1.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	
]

{ #category : #tests }
PhLImagesClapCommandTest >> testCreateImage [
	| repo command test1 test2 test3 variableOfTest |
	repo := PhLImagesMockRepo new.
	command := PhLImagesClapCommand new.
	command repository: repo.
	test1 := PhLImagesMock name: 'ljflkdjbf.image'.
	test2 := PhLImagesMock name: 'mytestimage.image'.
	test3 := PhLImagesMock name: 'blabla.image'.

	repo
		add: test1;
		add: test2;
		add: test3.

	command
		outputCreateImage: 'Pharo 8.0 - 64bit (stable)'
		to: 'myNewImage'.

	repo images
		do: [ :each | 
			each name = 'myNewImage'
				ifTrue: [ variableOfTest := 'itWorks' ] ].

	self assert: (repo images includes: test2).
	self assert: (repo images includes: test1).
	self assert: (repo images includes: test3).
	self assert: repo images size equals: 4.
	self assert: variableOfTest equals: 'itWorks'
]

{ #category : #tests }
PhLImagesClapCommandTest >> testCreateImagesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'images'].
	command := command subcommands detect:[ :f | f canonicalName ='create'].
	self assert: command flags size equals:1.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	
]

{ #category : #tests }
PhLImagesClapCommandTest >> testDeleteImage [

	| repo command test1 test2 test3 |
	
	repo := PhLImagesMockRepo new.
	command := PhLImagesClapCommand new.
	command repository: repo.
	test1 := PhLImagesMock name: 'ljflkdjbf.image'.
	test2 := PhLImagesMock name: 'mytestimage.image'.
	test3 := PhLImagesMock name: 'blabla.image'.
	
	repo
		add: test1;
		add: test2;
		add: test3.
		
	command outputDeleteImage: 'mytestimage.image'.
	
	self deny: (repo images includes: test2).
	self assert: (repo images includes: test1).
	self assert: (repo images includes: test3).
]

{ #category : #tests }
PhLImagesClapCommandTest >> testExecuteCommandImagesAsSton [
	| command output repo |
	command := PhLImagesClapCommand  new.
   repo := PhLImagesMockRepo new.
   repo images: OrderedCollection new.
   repo images add: (PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference).
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListImagesAsSton ].

	self assert: (STON fromString: output) equals: {repo images first file} asOrderedCollection.
]

{ #category : #tests }
PhLImagesClapCommandTest >> testExecuteCommandWhenThereAreManyImagePrintsTheListOfImages [
	| command output repo |
	command := PhLImagesClapCommand  new.
   repo := PhLImagesMockRepo new.
   repo images: OrderedCollection new.
   repo images add: (PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference).
   repo images add: (PhLImage location: 'asdsadaasdsad/Pharoblabla' asFileReference).
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListImages ].
   self assert: output equals: ('Pharo 8.0 - 64bit (stable)
 Pharoblabla
 ').
]

{ #category : #tests }
PhLImagesClapCommandTest >> testFindImage [
	| repo command test1 test2 test3 |
	repo := PhLImagesMockRepo new.
	repo images: OrderedCollection new.
	command :=PhLImagesClapCommand new.
	command repository: repo.
	test1 := PhLImagesMock  name: 'ljflkdjbf.image'.
	test2 := PhLImagesMock name: 'mytestimage.image'.
	test3 := PhLImagesMock name: 'blabla.image'.
	repo add: test1;
	     add: test2;
	     add: test3.
	command findImage:'mytestimage.image'
]

{ #category : #tests }
PhLImagesClapCommandTest >> testImagesInfoWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'images'].
	command := command subcommands detect:[ :f | f canonicalName ='info'].
	self assert: command flags size equals:1.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	
]

{ #category : #tests }
PhLImagesClapCommandTest >> testImagesLaunchWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'images'].
	command := command subcommands detect:[ :f | f canonicalName ='launch'].
	self assert: command flags size equals:1.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	
]

{ #category : #tests }
PhLImagesClapCommandTest >> testLaunchImage [

	| repo command test1 test2 test3 |
	
	repo := PhLImagesMockRepo new.
	command := PhLImagesClapCommand new.
	command repository: repo.
	test1 := PhLImagesMock name: 'ljflkdjbf.image'.
	test2 := PhLImagesMock name: 'mytestimage.image'.
	test3 := PhLImagesMock name: 'blabla.image'.

	repo
		add: test1;
		add: test2;
		add: test3.
		
	command outputImageLaunch: 'blabla.image'.
	
	self assert: test3 launchCheck equals: 'True'
]

{ #category : #tests }
PhLImagesClapCommandTest >> testListImagesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'images'].
	command := command subcommands detect:[ :f | f canonicalName ='list'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]
