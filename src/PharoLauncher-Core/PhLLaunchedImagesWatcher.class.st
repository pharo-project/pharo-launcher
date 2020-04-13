"
I'm in charge of watching launched images to detect if a problem occured at the launch.

To watch a process:
	PhLLaunchedImagesWatcher new
		checkProcess: aPhLProcess image: aPhLImage
"
Class {
	#name : #PhLLaunchedImagesWatcher,
	#superclass : #Object,
	#instVars : [
		'process',
		'image'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #initialization }
PhLLaunchedImagesWatcher class >> process: aPhLProcess image: aPhLImage [
	^ self new 
		process: aPhLProcess image: aPhLImage;
		yourself 
]

{ #category : #private }
PhLLaunchedImagesWatcher >> basicCheckProcess [
	| timeout pollingDelay failed |

	timeout := 5 seconds.
	pollingDelay := 500 milliSeconds.
	failed := false.
	[ timeout isZero or: [ failed ] ]
		whileFalse: [
			timeout := timeout - pollingDelay.
			pollingDelay wait.
			failed := self hasProcessFailed ].
	failed ifTrue: [ PhLLaunchError signalProcess: process image: image ]
]

{ #category : #initialization }
PhLLaunchedImagesWatcher >> check [
	"process ifNil: [ ^ self ]."
	
	[ self basicCheckProcess ]
		forkAt: self priority named: self name
]

{ #category : #testing }
PhLLaunchedImagesWatcher >> hasProcessFailed [
	process isRunning ifTrue: [ ^ false ].
	^ process isSuccess not
]

{ #category : #private }
PhLLaunchedImagesWatcher >> name [
	^ 'Pharo Launcher launched images watcher'
]

{ #category : #private }
PhLLaunchedImagesWatcher >> priority [
	^ 20
]

{ #category : #initialization }
PhLLaunchedImagesWatcher >> process: aPhLProcess image: aPhLImage [
	process := aPhLProcess.
	image := aPhLImage.
]
