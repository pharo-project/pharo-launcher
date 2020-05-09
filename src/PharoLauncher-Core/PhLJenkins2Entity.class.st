"
Abstract superclass for everything that is in a Jenkins server (and is visible from the JSON Jenkins API)
"
Class {
	#name : #PhLJenkins2Entity,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'properties',
		'parent',
		'childrenCache'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #testing }
PhLJenkins2Entity class >> isAbstract [
	^ self = PhLJenkins2Entity
]

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

{ #category : #accessing }
PhLJenkins2Entity >> children [
	"Since we need to request the network to get children, it is better to cache them.
	In the current use of the launcher, the jenkins entities are recreated each time we want to create a new image. Thus, we can cache the children, the probability of the jenkins been updated meanwhile."

	^ childrenCache ifNil: [ childrenCache := super children ]
]

{ #category : #accessing }
PhLJenkins2Entity >> icon [ 
	"(Base64MimeConverter mimeEncode: 'jenkins.png' asFileReference binaryReadStream) contents"

	^ (Form fromBase64String: 
'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAACBj
SFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAAL
EwEAmpwYAAACC2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4
PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJE
RiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1u
cyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4
bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyI+CiAgICAgICAgIDx0
aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDx0
aWZmOkNvbXByZXNzaW9uPjE8L3RpZmY6Q29tcHJlc3Npb24+CiAgICAgICAgIDx0aWZmOk9y
aWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgICAgIDx0aWZmOlBob3RvbWV0
cmljSW50ZXJwcmV0YXRpb24+MjwvdGlmZjpQaG90b21ldHJpY0ludGVycHJldGF0aW9uPgog
ICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KD0Uq
kwAACPlJREFUWAmVVwtQVOcV/u6+lwVWdmURWJ6u4gMUqA+MImmjURMdNRpfmWTaTDJTk4xJ
OtXJTKdpptNO0zbTSSedaTOBVtvG6BjHWG2MqAV1iiIkgjyDiLAssLzZ93tvz/+Tiyig9uzc
e/f+j3O+8/6vIBLhMYgtEwQB0WgUHXfacfFSJbo7u2CIk4/vVmhgMmdg3fr1SDaZ+DqZTPZI
zsLjAJCE93TbcK2qCuVfXUJRQSY2r1sNfZwGUQLndbrQ1m7Fmcs12P2j17B0SR6NRyETHg7i
kQCYxkyThvp6VF6oQCDow6anC7AwzQjR64Uv4EEwEoFCroRGo4XXH0DpZ19i24sHYLFkP9IS
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') magnifyBy: 0.5
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
PhLJenkins2Entity >> password [
	^ parent password
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

{ #category : #testing }
PhLJenkins2Entity >> shouldComputeChildrenLazily [
	"to know if the group has children, we need to send an ReST request. It can take a lot of time.
	It is better to do it lazily"
	^ true
]

{ #category : #accessing }
PhLJenkins2Entity >> url [
	"We get the URL from the json sent by Jenkins. In case of a secure Jenkins, we need to set the username and token to the URL we get."

	| url |
	url := (properties at: 'url') asUrl.
	self username ifNotNil: [ :username | url username: username ].
	self password ifNotNil: [ :token | url password: token ].
	^ url
]

{ #category : #accessing }
PhLJenkins2Entity >> username [
	^ parent username
]
