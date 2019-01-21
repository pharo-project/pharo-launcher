"
Announcement thrown when current templates sources do not match downloaded templates sources.
"
Class {
	#name : #PhLSourcesFileUpdateAvailable,
	#superclass : #Announcement,
	#instVars : [
		'sources'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLSourcesFileUpdateAvailable class >> sources: aListOfTemplateSources [ 
	^ self new 
		sources: aListOfTemplateSources;
		yourself
]

{ #category : #accessing }
PhLSourcesFileUpdateAvailable >> sources [
	^ sources
]

{ #category : #accessing }
PhLSourcesFileUpdateAvailable >> sources: aListOfTemplateSources [ 
	sources := aListOfTemplateSources
]
