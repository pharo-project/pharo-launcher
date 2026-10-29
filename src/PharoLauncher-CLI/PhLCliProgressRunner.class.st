"
I run long running operations (downloads, extractions) of a command line command and display their progress with a `ConsoleProgressBar`.
"
Class {
	#name : 'PhLCliProgressRunner',
	#superclass : 'ITProgressRunner',
	#instVars : [
		'outStream'
	],
	#category : 'PharoLauncher-CLI-Utility',
	#package : 'PharoLauncher-CLI',
	#tag : 'Utility'
}

{ #category : 'instance creation' }
PhLCliProgressRunner class >> on: aWriteStream [

	^ self new
		outStream: aWriteStream;
		yourself
]

{ #category : 'accessing' }
PhLCliProgressRunner >> outStream: aWriteStream [

	outStream := aWriteStream
]

{ #category : 'running' }
PhLCliProgressRunner >> run: aProgress [

	| job bar |
	job := self newJobFor: aProgress.
	bar := ConsoleProgressBar on: outStream.
	Job jobAnnouncer
		when: JobChange
		do: [ :change | change job == job ifTrue: [ bar updateJob: change ] ]
		for: bar.
	^ [ job run ]
		ensure: [ Job jobAnnouncer unsubscribe: bar ]
]
