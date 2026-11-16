"
I am a version of Pharo Launcher, as given by `git describe --tags`: '3.4.5', '4.0-alpha-2' (a pre-release), or '3.4.5-12-gabcdef0' (commits after the tag 3.4.5).
A development launcher has no tagged version ('N/A' or a commit hash): it is not comparable, so it is never older than a published version.

```
(PhLLauncherVersion fromString: '3.4.5') < (PhLLauncherVersion fromString: '3.4.6')
```
"
Class {
	#name : 'PhLLauncherVersion',
	#superclass : 'Object',
	#instVars : [
		'string',
		'numbers',
		'isPreRelease'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
PhLLauncherVersion class >> fromString: aString [

	^ self new
		  setString: aString;
		  yourself
]

{ #category : 'comparing' }
PhLLauncherVersion >> < aVersion [
	"Answer whether I am older than aVersion. Missing numbers are 0: 3.5 is 3.5.0.
	With the same numbers, a pre-release is older than the release."

	| size |
	size := numbers size max: aVersion numbers size.
	1 to: size do: [ :index |
		| mine theirs |
		mine := self numberAt: index.
		theirs := aVersion numberAt: index.
		mine = theirs ifFalse: [ ^ mine < theirs ] ].
	^ isPreRelease and: [ aVersion isPreRelease not ]
]

{ #category : 'testing' }
PhLLauncherVersion >> isComparable [

	^ numbers notEmpty
]

{ #category : 'testing' }
PhLLauncherVersion >> isPreRelease [

	^ isPreRelease
]

{ #category : 'private' }
PhLLauncherVersion >> numberAt: anIndex [

	^ numbers at: anIndex ifAbsent: [ 0 ]
]

{ #category : 'accessing' }
PhLLauncherVersion >> numbers [

	^ numbers
]

{ #category : 'printing' }
PhLLauncherVersion >> printOn: aStream [

	aStream nextPutAll: string
]

{ #category : 'initialization' }
PhLLauncherVersion >> setString: aString [
	"'3.4.5-12-gabcdef0' is 3.4.5 with commits after the tag: it is not a pre-release"

	| dashIndex suffix |
	string := aString.
	dashIndex := aString indexOf: $-.
	suffix := dashIndex = 0
		          ifTrue: [ '' ]
		          ifFalse: [ aString allButFirst: dashIndex ].
	numbers := ((dashIndex = 0
		             ifTrue: [ aString ]
		             ifFalse: [ aString first: dashIndex - 1 ]) substrings: '.')
		           collect: [ :each | each isAllDigits ifTrue: [ each asNumber ] ifFalse: [ nil ] ].
	(numbers isEmpty or: [ numbers includes: nil ]) ifTrue: [ numbers := #(  ) ].
	isPreRelease := suffix notEmpty and: [ (self isCommitsAfterTag: suffix) not ]
]

{ #category : 'private' }
PhLLauncherVersion >> isCommitsAfterTag: aSuffix [
	"'12-gabcdef0' as added by git describe"

	^ aSuffix matchesRegex: '\d+-g[0-9a-f]+'
]
