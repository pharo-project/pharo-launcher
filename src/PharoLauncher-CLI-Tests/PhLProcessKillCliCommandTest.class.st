"
A PhLImageKillCliCommandTest is a test class for testing the behavior of PhLImageKillCliCommand
"
Class {
	#name : #PhLProcessKillCliCommandTest,
	#superclass : #PhLProcessCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLProcessKillCliCommandTest >> testHasAllFlag [

	| killCliCommand |
	
	killCliCommand := (PhLProcessKillCliCommand asCliCommand activationWith: #('kill' '--all')) command.
	self assert: killCliCommand hasAllFlag.
	
	killCliCommand := (PhLProcessKillCliCommand asCliCommand activationWith: #('kill' 'someImageName')) command.
	self deny: killCliCommand hasAllFlag.
	

]

{ #category : #tests }
PhLProcessKillCliCommandTest >> testKillArgString [

	| killCliCommand aResult |
	
	killCliCommand := (PhLProcessKillCliCommand asCliCommand activationWith: #('kill' 'someImage.image')) command.
	
	aResult := killCliCommand killArgString.
	
	"test if command includes grep of image name"
	self assert: (aResult includesSubstring: 'grep someImage.image').
	"test whether current PID of vm is filtered from list"
	self assert: (aResult includesSubstring: ('grep -v ', (killCliCommand currentVMPid asString))).	
	"avoid doubling pipes in cascading"
	self deny: (aResult includesSubstring: '||').
]

{ #category : #tests }
PhLProcessKillCliCommandTest >> testKillArgStringWithAllFlag [

	| killCliCommand aResult |
	
	killCliCommand := (PhLProcessKillCliCommand asCliCommand activationWith: #('kill' '--all')) command.
	aResult := killCliCommand killArgString.
	
	"grep of image name shound not be included anymore"
	self deny: (aResult includesSubstring: 'grep someImage.image').
	"test whether current PID of vm is filtered from list"
	self assert: (aResult includesSubstring: ('grep -v ', (killCliCommand currentVMPid asString))).
]

{ #category : #tests }
PhLProcessKillCliCommandTest >> testMissingImageName [
	self runCommand: #('launcher' 'process' 'kill').
	
 	self assertFailure.
	self assert: ( self errorString includesSubstring: 'specify the local image name to kill it process')
]

{ #category : #tests }
PhLProcessKillCliCommandTest >> testOsShellArgArray [

	| killCliCommand  result|
	
	killCliCommand := (PhLProcessKillCliCommand asCliCommand activationWith: #('kill' 'someImageName')) command.
	
	result := killCliCommand osShellArgArray.
	
	self assert: (result first includesSubstring: 'kill').
	self assert: (result second includesSubstring: killCliCommand killArgString)
]
