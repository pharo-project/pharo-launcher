Extension { #name : #String }

{ #category : #'*PharoLauncher-CLI' }
String >> shortenTo: aSizeLimit [
	"returns shortened string up to desired limit, puts ' ... ' in the middle of shortened string."
	"('ABCDEF' shortenTo: 5) >>> ' ... '"
	"('ABCDEF' shortenTo: 6) >>> 'ABCDEF'"
	"('ABCDEF' shortenTo: 7) >>> 'ABCDEF'"
	"('ABCDEFGHIJ' shortenTo: 9) >>> 'A ... HIJ'"
	"('ABCDEFGHIJK' shortenTo: 10) >>> 'AB ... IJK'"
	
	|prefixIndex suffixIndex|
	
	self size <= aSizeLimit ifTrue: [ ^ self ].
	aSizeLimit <= 5 ifTrue: [ ^ ' ... ' ].
	prefixIndex := (aSizeLimit / 2) asInteger - 3.
	suffixIndex := self size - prefixIndex.
	aSizeLimit odd ifTrue: [ suffixIndex := suffixIndex -1 ].
	
	^ self class streamContents: [: aStream | 
		aStream 
			nextPutAll: (self copyFrom: 1 to: prefixIndex);
			nextPutAll: ' ... ';
	 		nextPutAll: (self copyFrom: suffixIndex to: self size)
	]
]
