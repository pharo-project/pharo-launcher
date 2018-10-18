"
I represent a run of a job (one configuration) resulting from a matrix job.
"
Class {
	#name : #PhLJenkins2Run,
	#superclass : #PhLJenkins2WithArtifactsEntity,
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #protected }
PhLJenkins2Run class >> jsonName [
	^ 'runs'
]

{ #category : #accessing }
PhLJenkins2Run >> name [
	^ String streamContents: [ :stream | self url jenkinsOptions printElementsOn: stream ]
]
