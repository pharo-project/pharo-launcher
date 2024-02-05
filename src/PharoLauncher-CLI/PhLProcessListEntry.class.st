"
I represent the output of a Shell process listing command for one entry.
I can parse this output to retrieve the Pharo VM and image.

Example of input string from a process listing command:
'933 /tmp/61d1f200-02cc-0d00-88d2-05d60e98deae/110-x64/pharo /tmp/61d1f200-02cc-0d00-88d2-05d60e98deae/PharoLauncher.image'
"
Class {
	#name : #PhLProcessListEntry,
	#superclass : #Object,
	#instVars : [
		'words',
		'vmIndex',
		'imageIndex'
	],
	#category : #'PharoLauncher-CLI-Utility'
}

{ #category : #'instance creation' }
PhLProcessListEntry class >> with: aString [

	^ self new
		shellString: aString;
		yourself
]

{ #category : #converting }
PhLProcessListEntry >> asImageProcess [

	^ PhLImageProcess new
		pid: self pidString;
		imagePath: self imagePath;
		vmPath: self vmPath
]

{ #category : #private }
PhLProcessListEntry >> computeImageIndex [

	imageIndex := words 
		detectIndex: [ :word | word includesSubstring: '.image' caseSensitive: false ]
		ifNone: [ 0 ]
]

{ #category : #private }
PhLProcessListEntry >> computeVmIndex [

	vmIndex := words 
		detectIndex: [ :word | word includesSubstring: 'pharo' caseSensitive: false ]
		ifNone: [ nil ]
]

{ #category : #accessing }
PhLProcessListEntry >> imagePath [

	vmIndex ifNil: [ ^ '' ].

	^ (
		String streamContents: [ :aStream |
		  words
			 from: vmIndex + 1 to: imageIndex
			 do: [ :word | (word beginsWith: '--') ifFalse: [ aStream nextPutAll: word; nextPut: Character space ] ].
		  words
			 from: imageIndex + 1 to: words size
			 do: [ :word | (word beginsWith: '--') ifTrue: [ aStream nextPutAll: word; nextPut: Character space ] ] ]
		) trim
]

{ #category : #private }
PhLProcessListEntry >> pidIndex [

	^ 1
]

{ #category : #accessing }
PhLProcessListEntry >> pidString [

	^ words at: self pidIndex
]

{ #category : #initialization }
PhLProcessListEntry >> shellString: aString [

	words := aString substrings.
	self computeVmIndex.
	self computeImageIndex
]

{ #category : #accessing }
PhLProcessListEntry >> vmPath [

	vmIndex ifNil: [ ^ '' ].
	
	^ (String streamContents: [:aStream | 
			words 
				from: self pidIndex + 1 to: vmIndex 
				do: [ :word | aStream nextPutAll: word; nextPut: Character space ].
			words from: vmIndex to: imageIndex 
				do: [ :word | (word beginsWith: '--') ifTrue: [ aStream nextPutAll: word; nextPut: Character space ] ]
	]) trim
]
