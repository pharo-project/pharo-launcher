"
This represents singleton object for accessing errorStream, outStream in methods used by CLI, that do not have any reference to streams of CLI command (or CLI context) object.
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
