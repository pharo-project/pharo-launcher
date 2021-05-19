"
Abstract superclass for everything in a Jenkins server that produces artifacts: currently, only simple jobs (i.e., non-matrix jobs) and runs (i.e., what is executed by a matrix job).
"
Class {
	#name : #PhLJenkins2WithArtifactsEntity,
	#superclass : #PhLJenkins2Entity,
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #protected }
PhLJenkins2WithArtifactsEntity class >> jsonFields [
	^ #('number' 'url')
]

{ #category : #accessing }
PhLJenkins2WithArtifactsEntity >> artifactTemplates [
	^ self artifacts
		inject: OrderedCollection new
		into: [ :templates :artifact | 
			artifact isPotentialTemplate
				ifTrue: [ templates add: artifact asTemplate ].
			templates ]
]

{ #category : #accessing }
PhLJenkins2WithArtifactsEntity >> artifacts [
	^ self query: PhLJenkinsArtifact
]

{ #category : #accessing }
PhLJenkins2WithArtifactsEntity >> name [
	^ '#', self number printString
]

{ #category : #accessing }
PhLJenkins2WithArtifactsEntity >> number [
	^ properties at: 'number'
]

{ #category : #accessing }
PhLJenkins2WithArtifactsEntity >> templatesAndGroups [
	^ self artifactTemplates
]
