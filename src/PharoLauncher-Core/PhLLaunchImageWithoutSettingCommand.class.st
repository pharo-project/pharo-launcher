"
As my super class I launch an image but I also disable the setting before the launch.
"
Class {
	#name : #PhLLaunchImageWithoutSettingCommand,
	#superclass : #PhLLaunchImageCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLLaunchImageWithoutSettingCommand class >> icon [
	^ super icon asGrayScaleWithAlpha 
]

{ #category : #accessing }
PhLLaunchImageWithoutSettingCommand class >> positionInGroup [
	^ 2
]

{ #category : #accessing }
PhLLaunchImageWithoutSettingCommand class >> title [
	^ 'Launch without setting'
]

{ #category : #action }
PhLLaunchImageWithoutSettingCommand >> launchImage: aPhLImage [
	aPhLImage launchWithSettings: false.
	self class quitOnLaunch
		ifTrue: [ self quit ]
]
