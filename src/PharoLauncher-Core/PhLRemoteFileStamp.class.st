"
I identify a version of a file published on a server, as given by the HTTP headers the server answers for this file.

Two stamps are equal when they identify the same version of the file.
"
Class {
	#name : 'PhLRemoteFileStamp',
	#superclass : 'Object',
	#instVars : [
		'etag',
		'lastModified'
	],
	#category : 'PharoLauncher-Core-Download',
	#package : 'PharoLauncher-Core',
	#tag : 'Download'
}

{ #category : 'instance creation' }
PhLRemoteFileStamp class >> etag: aString [

	^ self etag: aString lastModified: nil
]

{ #category : 'instance creation' }
PhLRemoteFileStamp class >> etag: aString lastModified: aDateAndTime [

	^ self new
		  setEtag: aString lastModified: aDateAndTime;
		  yourself
]

{ #category : 'accessing' }
PhLRemoteFileStamp class >> fileName [

	^ 'meta-inf.ston'
]

{ #category : 'instance creation' }
PhLRemoteFileStamp class >> fromHeaders: httpHeaders [

	| lastModified |
	lastModified := httpHeaders at: 'Last-Modified' ifAbsent: [ nil ].
	^ self
		  etag: (httpHeaders at: 'ETag' ifAbsent: [ nil ])
		  lastModified: (lastModified ifNotNil: [ ZnUtils parseHttpDate: lastModified ])
]

{ #category : 'instance creation' }
PhLRemoteFileStamp class >> inFolder: aFolder [
	"Answer the stamp stored in the given folder, nil if there is none."

	| file |
	file := aFolder / self fileName.
	^ file exists
		  ifTrue: [ file readStreamDo: [ :stream | STON fromStream: stream ] ]
		  ifFalse: [ nil ]
]

{ #category : 'comparing' }
PhLRemoteFileStamp >> = anObject [

	^ self class = anObject class and: [ etag = anObject etag ]
]

{ #category : 'accessing' }
PhLRemoteFileStamp >> etag [

	^ etag
]

{ #category : 'comparing' }
PhLRemoteFileStamp >> hash [

	^ etag hash
]

{ #category : 'testing' }
PhLRemoteFileStamp >> isNewerThan: aDateAndTime [

	^ lastModified isNotNil and: [ lastModified > aDateAndTime ]
]

{ #category : 'initialization' }
PhLRemoteFileStamp >> setEtag: aString lastModified: aDateAndTime [

	etag := aString.
	lastModified := aDateAndTime
]

{ #category : 'storing' }
PhLRemoteFileStamp >> storeInFolder: aFolder [

	(aFolder / self class fileName)
		ensureDelete;
		writeStreamDo: [ :stream | STON put: self onStreamPretty: stream ]
]
