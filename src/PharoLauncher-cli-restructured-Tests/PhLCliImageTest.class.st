Class {
	#name : #PhLCliImageTest,
	#superclass : #ClapPharoCommandsTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLCliImageTest >> testMatchImageCopy [
	"test just match of command line args, without activating command"
	
	self assert: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy')) isValid.
	self assert: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy' 'existingImage')) isValid.
	self assert: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy' 'existingImage' 'newImage')) isValid.
	
	self deny: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy' 'blah' '--nonsense' 'myNewName')) isValid.
	self deny: (PhLCliCommand launcherCommand match: #('launcher' 'image' 'copy' 'some' 'totally' 'random' 'stuff')) isValid.
]

{ #category : #tests }
PhLCliImageTest >> testMatchLauncher [
	"test just match of command line args, without activating command"
	
	self assert: (PhLCliCommand launcherCommand match: #('launcher')) isValid.
	self assert: (PhLCliCommand launcherCommand match: #('launcher' '--help')) isValid.
]

{ #category : #tests }
PhLCliImageTest >> testOutputDeleteImage [

	| command commandContext model imageName |
	model := PharoLauncherCLIModel new.
	model imageBaseRepository: PhLTestImageRepository new.	
	model imageBaseRepository createImageNamed: 'test2'.
	imageName := model imageBaseRepository singleImageName.	
	self
		assert: model imageBaseRepository imageNames asSet
		equals: #('TestImage' 'test2') asSet.		
				
	command := PhLImageDeleteCliCommand asCliCommand: model.
	commandContext := command activationWith: {'delete' . imageName}.
	
	commandContext execute.
	
	self
		assert: model imageBaseRepository imageNames asSet
		equals: #('test2') asSet
]

{ #category : #tests }
PhLCliImageTest >> testOutputImageCopy [

	| command commandContext model imageName |
	model := PharoLauncherCLIModel new.
	model imageBaseRepository: PhLTestImageRepository new.
	imageName := model imageBaseRepository singleImageName.		
	command := PhLImageCopyCliCommand asCliCommand: model.
	commandContext := command activationWith: { 'copy' . imageName . 'test2' }.

	commandContext execute.
	
	self
		assert: model imageBaseRepository imageNames asSet
		equals: { imageName . 'test2'} asSet
]

{ #category : #tests }
PhLCliImageTest >> testOutputImageInfo [

	| command commandContext output model imageName |
	
	model := PharoLauncherCLIModel new.
	model imageBaseRepository: PhLTestImageRepository new.	
	imageName := model imageBaseRepository singleImageName.		
	command := PhLImageInfoCliCommand asCliCommand: model.
	commandContext := command activationWith: {'info' . imageName }.
	
	commandContext execute.
	
	output := commandContext stdio stdout contents utf8Decoded lines. 
	self assert: ((output at:3) includesSubstring: 'version: 70').
]

{ #category : #tests }
PhLCliImageTest >> testOutputListmages [

	| command commandContext model  output |
	model := PharoLauncherCLIModel new.
	model imageBaseRepository: PhLTestImageRepository new.
	model imageBaseRepository createImageNamed: 'test2'.
	command := PhLImageListCliCommand asCliCommand: model.
	commandContext := command activationWith: {'list'}.
	
	commandContext execute.
	
	output := commandContext stdio stdout contents utf8Decoded. 
	self assert: (output includesSubstring: 'TestImage'). 
	self assert: (output includesSubstring: 'test2') 
]
