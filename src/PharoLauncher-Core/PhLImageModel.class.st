Class {
	#name : #PhLImageModel,
	#superclass : #Object,
	#instVars : [
		'image'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #'instance-creation' }
PhLImageModel class >> on: aPhLImage [ 
	^ self new
		image: aPhLImage;
		yourself
]

{ #category : #accessing }
PhLImageModel >> image: aPhLImage [ 
	image := aPhLImage
]

{ #category : #launching }
PhLImageModel >> launchWithSettings: aBoolean [
	
	| architectureWarningEnabled continue |
	architectureWarningEnabled := true.
	continue := true.
	[ [ image launchWithSettings: aBoolean ]
		on: PhLImageVersionDeterminationError, PhLNotSupportedCharacterError
		do: [ :error |  error uiAlert ] ]
		on: PhLArchitectureMismatchWarning
		do: [ :warning | |  |
			(PhLLaunchImageCommand warnOnArchMismatch and: [ architectureWarningEnabled  ])
				ifTrue: [ 
					architectureWarningEnabled := false. "only raise one warning"
					continue := YesNoDialogWithTickBoxWindow confirm: warning longDescription label: warning name. ].
			continue ifTrue: [ warning resume ]. ]
]
