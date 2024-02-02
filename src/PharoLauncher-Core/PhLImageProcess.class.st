"
I represent running Pharo image process. I have a known PID of running Pharo image process, image name, vm path, image Path start datetime of process. I am used mainly for pretty printing to user output.
"
Class {
	#name : #PhLImageProcess,
	#superclass : #PhLObject,
	#instVars : [
		'pid',
		'vmPath',
		'imagePath',
		'startDateTime'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #private }
PhLImageProcess class >> listPrintAttributeBlocks [

	^ {
		  [ :imgProcess | imgProcess pid asString ].
		  [ :imgProcess | imgProcess imageName ].
		  [ :imgProcess | imgProcess vmPath ].
		  [ :imgProcess | imgProcess imagePath ].
		  [ :imgProcess | imgProcess startDateTime ] }
]

{ #category : #private }
PhLImageProcess class >> listPrintAttributeLabels [

	^ #( 'PID' 'Image name' 'VM path' 'Image path' 'Date/Time started' )
]

{ #category : #accessing }
PhLImageProcess >> imageName [

	|fileName|
	self imagePath ifEmpty: [ ^ '' ].
	fileName := self imagePath copyAfterLast: FileSystem disk delimiter.
	fileName ifEmpty: [ fileName := self imagePath  ].
	^ fileName  copyUpTo: $.
]

{ #category : #accessing }
PhLImageProcess >> imagePath [

	^ imagePath
]

{ #category : #accessing }
PhLImageProcess >> imagePath: anObject [

	imagePath := anObject
]

{ #category : #initialization }
PhLImageProcess >> initializeFrom: processLineArray [

	self pid: processLineArray first.
	self vmPath: processLineArray second.
	self imagePath: processLineArray third.
	self startDateTime: processLineArray fourth.
]

{ #category : #accessing }
PhLImageProcess >> pid [

	^ pid
]

{ #category : #accessing }
PhLImageProcess >> pid: anObject [

	pid := anObject
]

{ #category : #accessing }
PhLImageProcess >> startDateTime [

	^ startDateTime
]

{ #category : #accessing }
PhLImageProcess >> startDateTime: anObject [

	startDateTime := anObject
]

{ #category : #accessing }
PhLImageProcess >> vmPath [

	^ vmPath
]

{ #category : #accessing }
PhLImageProcess >> vmPath: anObject [

	vmPath := anObject
]
