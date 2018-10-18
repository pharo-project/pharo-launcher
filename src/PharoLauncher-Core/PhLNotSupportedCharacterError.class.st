"
Error raised when Pharo Launcher needs to run an external command and that some characters of the command are not supported by the backend (e.g. non ASCII characters on Windows with ProcessWrapper).
"
Class {
	#name : #PhLNotSupportedCharacterError,
	#superclass : #PhLError,
	#category : 'PharoLauncher-Core-Download'
}

{ #category : #accessing }
PhLNotSupportedCharacterError >> longDescription [
	^ 'On Windows, Pharo Launcher can only run commands with ASCII characters (known limitation). You get this error because either you tried to run an image whose fullPath contains non ASCII characters, either the vm store (in the Documents folder) contains non ASCII characters.
To solve this problem, either rename the image file if it contains non-ASCII characters, either move the image and/or VM store if it contains non-ASCII characters and update the pathes in the settings.'
]

{ #category : #accessing }
PhLNotSupportedCharacterError >> name [
	^ 'Not supported character detected!'
]
