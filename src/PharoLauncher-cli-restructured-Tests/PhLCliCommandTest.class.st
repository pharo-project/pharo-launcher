Class {
	#name : #PhLCliCommandTest,
	#superclass : #ClapPharoCommandsTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLCliCommandTest >> testExecute [
	context := PhLCliCommand launcherCommand activateWith: #('launcher').
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
