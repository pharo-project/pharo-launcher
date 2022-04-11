"
A PhLImageKillCliCommandTest is a test class for testing the behavior of PhLImageKillCliCommand
"
Class {
	#name : #PhLImageKillCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #test }
PhLImageKillCliCommandTest >> testAllFlag [

	| killCliCommand  aMatch aMatch2|
	
	aMatch := (context arguments: #('launcher' 'image' 'kill' '--all')) doMatch.
	aMatch := (aMatch at: #image) at: #kill.
	
	aMatch2 := (context arguments: #('launcher' 'image' 'kill' 'someImageName')) doMatch.
	aMatch2 := (aMatch2 at: #image) at: #kill.
	
	killCliCommand :=  PhLImageKillCliCommand new.

	killCliCommand setArguments: aMatch.
	self assert: killCliCommand allFlag.

	killCliCommand setArguments: aMatch2.
	self deny: killCliCommand allFlag.
	

]

{ #category : #test }
PhLImageKillCliCommandTest >> testKillArgString [

	| killCliCommand aResult aMatch|
	
	killCliCommand :=  PhLImageKillCliCommand new.
	aMatch := (context arguments: #('launcher' 'image' 'kill' 'someImage.image')) doMatch.
	aMatch := (aMatch at: #image) at: #kill.
	killCliCommand setArguments: aMatch.
	
		
	aResult := killCliCommand killArgString.
	
	"test if command includes grep of image name"
	self assert: (aResult includesSubstring: 'grep someImage.image').
	
	"test whether current PID of vm is filtered from list"
	self assert: (aResult includesSubstring: ('grep -v ', (killCliCommand currentVMPid asString))).
	
	"avoid doubling pipes in cascading"
	self deny: (aResult includesSubstring: '||').
	
	"test same method with --all argument present"
	aMatch := (context arguments: #('launcher' 'image' 'kill' '--all')) doMatch.
	aMatch := (aMatch at: #image) at: #kill.
	killCliCommand setArguments: aMatch.
	
		
	aResult := killCliCommand killArgString.
	"grep of image name shound not be included anymore"
	self deny: (aResult includesSubstring: 'grep someImage.image').

	"test whether current PID of vm is filtered from list"
	self assert: (aResult includesSubstring: ('grep -v ', (killCliCommand currentVMPid asString))).
]

{ #category : #test }
PhLImageKillCliCommandTest >> testOsShellArgArray [

	| killCliCommand  aMatch result|
	
	aMatch := (context arguments: #('launcher' 'image' 'kill' 'someImageName')) doMatch.
	aMatch := (aMatch at: #image) at: #kill.
	
	killCliCommand :=  PhLImageKillCliCommand new.

	killCliCommand setArguments: aMatch.
	result := killCliCommand osShellArgArray.
	
	self assert: (result first includesSubstring: 'kill').
	self assert: (result second includesSubstring: killCliCommand killArgString).
	
]
