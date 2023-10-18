"
I represent an object to manage notifications to user when ran in CLI mode.

I can act as the PharoLauncher default application (see PharoLauncherApplication class>>#default).
I only have a minimal set of methods to provide some polymorphism with an SpApplication and avoid UI interactions.
"
Class {
	#name : #PhLNotificationCenter,
	#superclass : #Object,
	#instVars : [
		'outStream',
		'errorStream'
	],
	#classVars : [
		'Default'
	],
	#category : #'PharoLauncher-CLI-Utility'
}

{ #category : #'class initialization' }
PhLNotificationCenter class >> beInitializedByClapContextStreams [

	<script>
	(ClapContext >> #initialize) ast link: (MetaLink new
			 metaObject: #receiver;
			 selector: #initializeLauncherNotificationCenter;
			 control: #after)
]

{ #category : #accessing }
PhLNotificationCenter class >> default [ 
	^ Default ifNil: [ Default := self new ]
]

{ #category : #'class initialization' }
PhLNotificationCenter class >> initialize [

	self beInitializedByClapContextStreams
]

{ #category : #accessing }
PhLNotificationCenter >> errorStream [
	^ errorStream 
]

{ #category : #accessing }
PhLNotificationCenter >> errorStream: anErrorStream [
	errorStream := anErrorStream
]

{ #category : #accessing }
PhLNotificationCenter >> outStream [
	^ outStream 
]

{ #category : #accessing }
PhLNotificationCenter >> outStream: anOutStream [
	outStream := anOutStream 
]

{ #category : #ui }
PhLNotificationCenter >> pushProgress: aString with: aFullBlockClosure [ 
	"do not display progress, only evaluate the block"
	aFullBlockClosure value: DummySystemProgressItem new
]

{ #category : #polymorphism }
PhLNotificationCenter >> reset [

	"This method is not a 'real' reset but is there for polymorphism with `PharoLauncherApplication`.
	It is called by `PhLStartupManager class>>#startUp:`.
	One should not reset my streams as they are initialized by clap at image startup."
]

{ #category : #ui }
PhLNotificationCenter >> showError: anError [

	self errorStream
		nextPutAll: 'Error: ';
		nextPutAll: anError name;
		nextPutAll: ' - ';
		nextPutAll: anError longDescription;
		cr
]
