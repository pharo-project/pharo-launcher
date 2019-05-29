"
This class is in charge of watching the execution of the process given as input to check regularly if it is still running or not.
When the process is completed, I do a callback on the process so that it cleans the process fields.
"
Class {
	#name : #PhLWinProcessWatcher,
	#superclass : #Object,
	#instVars : [
		'watchProcess',
		'process'
	],
	#pools : [
		'PhLWinTypes'
	],
	#category : #'PharoLauncher-WinProcess'
}

{ #category : #'instance creation' }
PhLWinProcessWatcher class >> on: aProcess [
	^ self new 
		process: aProcess
]

{ #category : #accessing }
PhLWinProcessWatcher >> process: aProcess [
	process := aProcess
]

{ #category : #watching }
PhLWinProcessWatcher >> watch [
	"active loop to catch the end of the process"

	watchProcess := [ [ process isRunning ]
		whileTrue: [ 200 milliSeconds wait ].
		process completionCallback ]
		forkAt: 35
		named: 'WinProcess watcher'
]
