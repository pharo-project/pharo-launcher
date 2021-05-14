Class {
	#name : #PhLImagesClapCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'stream'
	],
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #tests }
PhLImagesClapCommandTest >> testCopyImagesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'images'].
	command := command subcommands detect:[ :f | f canonicalName ='copy'].
	self assert: command flags size equals:1.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	
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
PhLImagesClapCommandTest >> testExecuteCommandCopyImage [
	| command repo size test|
	size :=0.
	command := PhLImagesClapCommand  new.
   repo := PhLImagesMockRepo new.
   repo images: OrderedCollection new.
   repo images add: (PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference).
   repo images add: (PhLImage location: 'asdsadaasdsad/Pharoblabla.image' asFileReference).
   command repository: repo.
	command outputCopyImage:'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' to:'blakjbzkabj'.
	repo images do: [:each | size:=size+1. ].
   self assert: size equals:3.
]

{ #category : #tests }
PhLImagesClapCommandTest >> testExecuteCommandDeleteImage [
	| command repo test |
	command := PhLImagesClapCommand  new.
   repo := PhLImagesMockRepo new.
   repo images: OrderedCollection new.
   test := PhLImage location: 'asdsadaasdsad/Pharoblabla.image' asFileReference.
   repo images add: (PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference).
   repo images add: (test).
	command repository: repo.
	self assert:(repo images includes: test).
	self halt.
	command outputDeleteImage: 'Pharoblabla.image'.
   self deny: (repo images includes: test).
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
PhLImagesClapCommandTest >> testListImagesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'images'].
	command := command subcommands detect:[ :f | f canonicalName ='list'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]
