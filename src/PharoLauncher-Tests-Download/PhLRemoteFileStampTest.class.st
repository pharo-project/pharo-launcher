"
I specify how stamps of files published on a server tell that a file did not change.
"
Class {
	#name : 'PhLRemoteFileStampTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLRemoteFileStampTest >> date [

	^ DateAndTime year: 2026 month: 11 day: 16 hour: 10 minute: 20 second: 30 offset: Duration zero
]

{ #category : 'tests' }
PhLRemoteFileStampTest >> testDictionaryOfAStampWithoutValidatorIsEmpty [

	self assertEmpty: (PhLRemoteFileStamp etag: nil lastModified: nil) asDictionary
]

{ #category : 'tests' }
PhLRemoteFileStampTest >> testIdentifiesSameFileByEtag [

	self assert: ((PhLRemoteFileStamp etag: 'a') identifiesSameFileAs: (PhLRemoteFileStamp etag: 'a')).
	self deny: ((PhLRemoteFileStamp etag: 'a') identifiesSameFileAs: (PhLRemoteFileStamp etag: 'b'))
]

{ #category : 'tests' }
PhLRemoteFileStampTest >> testIdentifiesSameFileByModificationDateWithoutEtag [

	self assert: ((PhLRemoteFileStamp etag: nil lastModified: self date) identifiesSameFileAs:
			 (PhLRemoteFileStamp etag: nil lastModified: self date)).
	self deny: ((PhLRemoteFileStamp etag: nil lastModified: self date) identifiesSameFileAs:
			 (PhLRemoteFileStamp etag: nil lastModified: self date + 1 second))
]

{ #category : 'tests' }
PhLRemoteFileStampTest >> testIsReadBackFromItsDictionary [

	| stamp readStamp |
	stamp := PhLRemoteFileStamp etag: '"abc"' lastModified: self date.

	readStamp := PhLRemoteFileStamp fromDictionary: (STONJSON fromString: (STONJSON toString: stamp asDictionary)).

	self assert: readStamp etag equals: '"abc"'.
	self assert: readStamp lastModified equals: self date
]

{ #category : 'tests' }
PhLRemoteFileStampTest >> testStampsWithDifferentValidatorsDoNotIdentifyTheSameFile [

	self deny: ((PhLRemoteFileStamp etag: 'a' lastModified: nil) identifiesSameFileAs:
			 (PhLRemoteFileStamp etag: nil lastModified: self date))
]

{ #category : 'tests' }
PhLRemoteFileStampTest >> testStampsWithoutValidatorDoNotIdentifyTheSameFile [
	"Without ETag nor modification date, nothing tells the file did not change"

	| stamp |
	stamp := PhLRemoteFileStamp etag: nil lastModified: nil.

	self deny: (stamp identifiesSameFileAs: stamp)
]
