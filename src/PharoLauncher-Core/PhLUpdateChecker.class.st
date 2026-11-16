"
Process used to regularly do checks for available updates, one after the other.
A check is a block.

```
PhLUpdateChecker runChecks: { [ PhLTemplateSourcesUpdateChecker new check ] }.
PhLUpdateChecker terminate
```

Command line uses a different template sources check. See `PhLCliTemplateSourcesChecker` class
"
Class {
	#name : 'PhLUpdateChecker',
	#superclass : 'Object',
	#instVars : [
		'checks',
		'process'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
PhLUpdateChecker class >> checks: aCollectionOfBlocks [

	^ self new
		  setChecks: aCollectionOfBlocks;
		  yourself
]

{ #category : 'running' }
PhLUpdateChecker class >> runChecks: aCollectionOfBlocks [

	self terminate.
	UniqueInstance := self checks: aCollectionOfBlocks.
	UniqueInstance run
]

{ #category : 'running' }
PhLUpdateChecker class >> terminate [

	UniqueInstance ifNotNil: [ :checker | checker terminate ]
]

{ #category : 'actions' }
PhLUpdateChecker >> check [
	"A failing check must not prevent the other ones, nor stop the process doing the checks regularly"

	checks do: [ :each |
		[ each value ]
			on: Error
			do: [ :error | ('Pharo Launcher update check failed: ' , error description) traceCr ] ]
]

{ #category : 'accessing' }
PhLUpdateChecker >> name [

	^ 'Launcher update checker'
]

{ #category : 'accessing' }
PhLUpdateChecker >> priority [

	^ 20
]

{ #category : 'actions' }
PhLUpdateChecker >> run [

	self terminate.
	process := [
	           [
	           self check.
	           self wait ] repeat ] forkAt: self priority named: self name
]

{ #category : 'initialization' }
PhLUpdateChecker >> setChecks: aCollectionOfBlocks [

	checks := aCollectionOfBlocks
]

{ #category : 'actions' }
PhLUpdateChecker >> terminate [

	process ifNotNil: [
		process isTerminating ifFalse: [ process terminate ] ]
]

{ #category : 'actions' }
PhLUpdateChecker >> wait [

	24 hours wait
]
