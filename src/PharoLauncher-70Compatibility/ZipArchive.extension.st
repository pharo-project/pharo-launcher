Extension { #name : #ZipArchive }

{ #category : #'*PharoLauncher-70Compatibility' }
ZipArchive >> readFrom: aStreamOrFile [
	| stream name eocdPosition |
	stream := aStreamOrFile isStream
		ifTrue: [ name := aStreamOrFile printString. aStreamOrFile ]
		ifFalse: [ name := aStreamOrFile asFileReference fullName. aStreamOrFile asFileReference binaryReadStream ].
	eocdPosition := self class findEndOfCentralDirectoryFrom: stream.
	eocdPosition <= 0 ifTrue: [ ZipArchiveError signal: 'can''t find EOCD position' ].
	self readEndOfCentralDirectoryFrom: stream.
	stream position: eocdPosition - centralDirectorySize.
	self readMembersFrom: stream named: name
]
