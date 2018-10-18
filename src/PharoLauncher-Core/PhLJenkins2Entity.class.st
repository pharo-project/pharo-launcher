"
Abstract superclass for everything that is in a Jenkins server (and is visible from the JSON Jenkins API)
"
Class {
	#name : #PhLJenkins2Entity,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'properties',
		'parent'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #protected }
PhLJenkins2Entity class >> jsonFields [
	^ self subclassResponsibility
]

{ #category : #protected }
PhLJenkins2Entity class >> jsonFieldsQuery [
	^ $, join: self jsonFields
]

{ #category : #protected }
PhLJenkins2Entity class >> jsonName [
	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
PhLJenkins2Entity class >> newWithProperties: json [ 
	^ self new
		setProperties: json;
		yourself
]

{ #category : #'as yet unclassified' }
PhLJenkins2Entity >> hasChildren [
	^ true
]

{ #category : #protected }
PhLJenkins2Entity >> jsonQuery: query [
	| queryUrl |
	queryUrl := self url / 'api' / 'json' ? ('tree' -> query).
	^ STONJSON
		fromStream: (PhLDownloadManager default downloadToPositionableStream: queryUrl mimeType: ZnMimeType applicationJson)
]

{ #category : #accessing }
PhLJenkins2Entity >> parent: aPhLEntity [
	parent := aPhLEntity
]

{ #category : #accessing }
PhLJenkins2Entity >> properties [
	^ properties
]

{ #category : #protected }
PhLJenkins2Entity >> query: jenkinsType [
	| query |
	query := jenkinsType jsonName , '[' , jenkinsType jsonFieldsQuery , ']'.
	^ ((self jsonQuery: query) at: jenkinsType jsonName ifAbsent: [nil])
		ifNil: [ #() ]
		ifNotNil: [ :jsonObjects | 
			jsonObjects
				collect: [ :json | 
					(jenkinsType newWithProperties: json)
						parent: self;
						yourself ] ]
]

{ #category : #initialization }
PhLJenkins2Entity >> setProperties: json [ 
	properties := json
]

{ #category : #accessing }
PhLJenkins2Entity >> url [
	^ (properties at: 'url') asUrl
]
