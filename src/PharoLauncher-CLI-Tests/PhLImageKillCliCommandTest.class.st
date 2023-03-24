"
A PhLImageKillCliCommandTest is a test class for testing the behavior of PhLImageKillCliCommand
"
Class {
	#name : #PhLImageKillCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageKillCliCommandTest >> testAllFlag [

	| killCliCommand |
	
	killCliCommand := (PhLImageKillCliCommand asCliCommand activationWith: #('kill' '--all')) command.
	self assert: killCliCommand allFlag.
	
	killCliCommand := (PhLImageKillCliCommand asCliCommand activationWith: #('kill' 'someImageName')) command.
	self deny: killCliCommand allFlag.
	

]

{ #category : #tests }
PhLImageKillCliCommandTest >> testKillArgString [

	| killCliCommand aResult |
	
	killCliCommand := (PhLImageKillCliCommand asCliCommand activationWith: #('kill' 'someImage.image')) command.
	
	aResult := killCliCommand killArgString.
	
	"test if command includes grep of image name"
	self assert: (aResult includesSubstring: 'grep someImage.image').
	
	"test whether current PID of vm is filtered from list"
	self assert: (aResult includesSubstring: ('grep -v ', (killCliCommand currentVMPid asString))).
	
	"avoid doubling pipes in cascading"
	self deny: (aResult includesSubstring: '||').
	
	"test same method with --all argument present"
	killCliCommand := (PhLImageKillCliCommand asCliCommand activationWith: #('kill' '--all')) command.
	aResult := killCliCommand killArgString.
	
	"grep of image name shound not be included anymore"
	self deny: (aResult includesSubstring: 'grep someImage.image').

	"test whether current PID of vm is filtered from list"
	self assert: (aResult includesSubstring: ('grep -v ', (killCliCommand currentVMPid asString))).
]

{ #category : #tests }
PhLImageKillCliCommandTest >> testOsShellArgArray [

	| killCliCommand  result|
	

	killCliCommand := (PhLImageKillCliCommand asCliCommand activationWith: #('kill' 'someImageName')) command.
	result := killCliCommand osShellArgArray.
	
	self assert: (result first includesSubstring: 'kill').
	self assert: (result second includesSubstring: killCliCommand killArgString)
]
