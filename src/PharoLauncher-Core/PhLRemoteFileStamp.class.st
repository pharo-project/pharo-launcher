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

{ #category : 'instance creation' }
PhLRemoteFileStamp class >> fromHeaders: httpHeaders [

	| lastModified |
	lastModified := httpHeaders at: 'Last-Modified' ifAbsent: [ nil ].
	^ self
		  etag: (httpHeaders at: 'ETag' ifAbsent: [ nil ])
		  lastModified: (lastModified ifNotNil: [ ZnUtils parseHttpDate: lastModified ])
]

{ #category : 'comparing' }
PhLRemoteFileStamp >> = anObject [

	^ self class = anObject class and: [ etag = anObject etag ]
]

{ #category : 'converting' }
PhLRemoteFileStamp >> asVmMetadata [
	"meta-inf.ston of a VM only held the stamp of its installed archive in the first versions"

	^ PhLVmMetadata new
		  setInstalledStamp: self;
		  yourself
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

{ #category : 'accessing' }
PhLRemoteFileStamp >> publicationDate [
	"Answer the date the file was published on the server, nil if unknown."

	^ lastModified ifNotNil: [ lastModified asLocal asDate ]
]

{ #category : 'initialization' }
PhLRemoteFileStamp >> setEtag: aString lastModified: aDateAndTime [

	etag := aString.
	lastModified := aDateAndTime
]

