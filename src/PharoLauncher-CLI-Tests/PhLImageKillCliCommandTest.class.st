"
A PhLImageKillCliCommandTest is a test class for testing the behavior of PhLImageKillCliCommand
"
Class {
	#name : #PhLImageKillCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageKillCliCommandTest >> testKillImageCmdStringFrom [
	| killCliCommand aResult |
	killCliCommand := PhLImageKillCliCommand new.
	
	"test if not raise exceptions with various input parameters"
	killCliCommand killImageCmdStringFrom: ''.
	killCliCommand killImageCmdStringFrom: nil.
	
	aResult := killCliCommand killImageCmdStringFrom: 'someImage.image'.
	
	"test if command includes grep of image name"
	self assert: (aResult includesSubstring: 'grep someImage.image').
	
	"test whether current PID of vm is filtered from list"
	self assert: (aResult includesSubstring: ('grep -v ', (killCliCommand currentVMPid asString))).
	
	"avoid doubling pipes in cascading"
	self deny: (aResult includesSubstring: '||').
]
