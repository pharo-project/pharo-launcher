"
Represent a file artifact as built on a Jenkins server.

Instance Variables
	name:		a String
	options:		a dictionary mapping option names to option values. Used by Jenkins matrix jobs
	url:		location of job on Jenkins

"
Class {
	#name : #PhLJenkinsArtifact,
	#superclass : #Object,
	#instVars : [
		'properties',
		'parent'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #protected }
PhLJenkinsArtifact class >> jsonFields [
	^ #('relativePath')
]

{ #category : #protected }
PhLJenkinsArtifact class >> jsonFieldsQuery [
	^ $, join: self jsonFields
]

{ #category : #protected }
PhLJenkinsArtifact class >> jsonName [
	^ 'artifacts'
]

{ #category : #'instance creation' }
PhLJenkinsArtifact class >> newWithProperties: json [ 
	^ self new
		setProperties: json;
		yourself
]

{ #category : #converting }
PhLJenkinsArtifact >> asTemplate [
	^ PhLRemoteTemplate name: self fullName url: self url
]

{ #category : #accessing }
PhLJenkinsArtifact >> fileExtension [
	^ self url lastPathSegment copyAfterLast: $.
]

{ #category : #accessing }
PhLJenkinsArtifact >> fullName [
	^ self options
		ifEmpty: [ self name ]
		ifNotEmpty: [ :options | String
				streamContents: [ :s | 
					s
						<< $(;
						<< self url lastPathSegment;
						<< $);
						space;
						<< self name.
					options
						keysAndValuesDo: [ :key :value | 
							s space
								<< key;
								<< '=';
								<< value ] ] ]
]

{ #category : #testing }
PhLJenkinsArtifact >> isPotentialTemplate [
	^ self fileExtension = 'zip' "In a better world we would distinguish potential images differently"
]

{ #category : #accessing }
PhLJenkinsArtifact >> name [
	^ self relativePath
]

{ #category : #accessing }
PhLJenkinsArtifact >> options [
	"Return a dictionary of the options used to build this artifact (typically the version of the image, the version of the project...)."

	"Because Jenkins doesn't store this information properly, we have to parse it from the url"
	^ parent url jenkinsOptions
]

{ #category : #accessing }
PhLJenkinsArtifact >> parent: aBuildOrRun [
	parent := aBuildOrRun
]

{ #category : #accessing }
PhLJenkinsArtifact >> relativePath [
	^ properties at: 'relativePath'
]

{ #category : #initialization }
PhLJenkinsArtifact >> setProperties: json [
	properties := json
]

{ #category : #accessing }
PhLJenkinsArtifact >> url [
	"Jenkins JSON API does not assign urls to artifacts. You have to get the url of build or run that defines the artifact (i.e., the artifact's parent)."
	^ parent url / 'artifact' / self relativePath
]
