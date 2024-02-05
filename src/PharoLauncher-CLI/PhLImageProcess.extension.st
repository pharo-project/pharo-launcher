Extension { #name : #PhLImageProcess }

{ #category : #'*PharoLauncher-CLI' }
PhLImageProcess class >> newFrom: osOutputLine [

	"initialize image process instance from line represented by OS command output line"
	^  (PhLProcessListEntry with: osOutputLine) asImageProcess	
]
