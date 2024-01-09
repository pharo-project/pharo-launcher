"
Error thrown when Pharo Launcher did not succeed to determine the Pharo version of the image to launch.
Probably, the run command failed.
I hold the command run to determoine the version so that it can be reused for debugging purposes.
"
Class {
	#name : #PhLImageVersionFileNotFound,
	#superclass : #PhLError,
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #accessing }
PhLImageVersionFileNotFound >> longDescription [
	^ PhLImage versionFileName , 
	' file was not found for your image, and probably your VMs are not up to date.
Please, contact us at http://pharo.org/community'
]

{ #category : #accessing }
PhLImageVersionFileNotFound >> messageText [ 

	^ self longDescription
]

{ #category : #accessing }
PhLImageVersionFileNotFound >> name [
	^ 'Image version file ', PhLImage versionFileName , ' not found!'
]
