Class {
	#name : #PhLCliCommandTest,
	#superclass : #ClapPharoCommandsTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLCliCommandTest >> emptyImageRepository [
	^ PhLDirectoryBasedImageRepository forDirectory: FileSystem memory workingDirectory
]

{ #category : #tests }
PhLCliCommandTest >> newImageRepositoryWithAnImage [
	| repository baseDirectory |
	repository := self emptyImageRepository.
	baseDirectory := repository baseDirectory.
	(baseDirectory / 'test') ensureCreateDirectory.
	(baseDirectory / 'test' / 'test.image') ensureCreateFile.
	(baseDirectory / 'test' / 'test.changes') ensureCreateFile.
	^ repository
]

{ #category : #tests }
PhLCliCommandTest >> testExecute [
   |command commandContext|
   command :=PhLCliCommand launcherCommand.
   commandContext := command activationWith: #('launcher' 'image' 'copy' 'mytestimage.image' 'mytestimagecopy.image').
   "command repository: PhLBaseDirectory."
   
   commandContext execute. 
	
	self assertSuccess.
	self
		assert: self outputString
		equals: 'some content here' , self lineEnding
		
		

]

{ #category : #tests }
PhLCliCommandTest >> testMatchImageCopy [
	"test just match of command line args, without activating command"
	
	self assert: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy')) isValid.
	self assert: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy' 'existingImage')) isValid.
	self assert: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy' 'existingImage' 'newImage')) isValid.
	
	self deny: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy' 'blah' '--nonsense' 'myNewName')) isValid.
	self deny: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy' 'some' 'totally' 'random' 'stuff')) isValid.
]

{ #category : #tests }
PhLCliCommandTest >> testMatchLauncher [
	"test just match of command line args, without activating command"
	
	self assert: (PhLCliCommand launcherCommand match: #('launcher')) isValid.
	self assert: (PhLCliCommand launcherCommand match: #('launcher' '--help')) isValid.
]

{ #category : #tests }
PhLCliCommandTest >> testOutputImageCopy [
	| command commandContext test |
	test := PharoLauncherCLIModel new.
	test imageBaseRepository: self newImageRepositoryWithAnImage.
	self
		assert: test imageBaseRepository imageNames asSet
		equals: #('test') asSet.
	command := PhLImageCopyCliCommand asCliCommand: test.
	commandContext := command activationWith: #('copy' 'test' 'test2').
	commandContext execute.
	self
		assert: test imageBaseRepository imageNames asSet
		equals: #('test' 'test2') asSet
]
