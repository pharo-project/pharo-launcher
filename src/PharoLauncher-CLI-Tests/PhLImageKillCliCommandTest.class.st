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
	
	|killCliCommand|
	killCliCommand := PhLImageKillCliCommand new.
	self assert: (killCliCommand killImageCmdStringFrom: '') equals: 'kill $(ps x | grep  -i Pharo | grep ''.image'' | tr -s '' '' | cut -d '' '' -f1)'.
	
	self assert: (killCliCommand killImageCmdStringFrom: 'someImage.image') equals: 'kill $(ps x | grep  -i Pharo | grep ''.image'' | grep someImage.image | tr -s '' '' | cut -d '' '' -f1)'.
]
