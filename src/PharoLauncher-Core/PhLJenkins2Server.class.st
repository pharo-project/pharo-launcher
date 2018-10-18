"
I represent a group of templates as built by a Jenkins server (url of the server is in my url instance variable). I use Jenkins' JSON API to get the data from the server.

"
Class {
	#name : #PhLJenkins2Server,
	#superclass : #PhLJenkins2Entity,
	#instVars : [
		'url',
		'name'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLJenkins2Server class >> inriaMoose [
	^ self name: 'Moose Jenkins' url: 'https://ci.inria.fr/moose' asZnUrl
]

{ #category : #'instance creation' }
PhLJenkins2Server class >> inriaPharo [
	^ self name: 'Pharo Jenkins' url: 'https://ci.inria.fr/pharo' asZnUrl
]

{ #category : #'instance creation' }
PhLJenkins2Server class >> inriaPharoContribution [
	^ self name: 'Pharo Contribution Jenkins' url: 'https://ci.inria.fr/pharo-contribution' asZnUrl
]

{ #category : #'instance creation' }
PhLJenkins2Server class >> inriaRmod [
	^ self name: 'RMoD Jenkins' url: 'https://ci.inria.fr/rmod' asZnUrl
]

{ #category : #'instance creation' }
PhLJenkins2Server class >> name: aString url: anUrl [
	^ self new
		setName: aString url: anUrl;
		yourself
]

{ #category : #accessing }
PhLJenkins2Server >> jobs [
	^ self query: PhLJenkins2Job
]

{ #category : #accessing }
PhLJenkins2Server >> name [
	^ name
]

{ #category : #initialization }
PhLJenkins2Server >> setName: aString url: aZnUrl [ 
	name := aString.
	url := aZnUrl
]

{ #category : #accessing }
PhLJenkins2Server >> templatesAndGroups [
	^ self jobs
]

{ #category : #accessing }
PhLJenkins2Server >> url [
	^ url
]
