"
Progress runner for test purposes: I run the work and record the title of each progress that would be displayed to the user.
"
Class {
	#name : 'PhLRecordingProgressRunner',
	#superclass : 'ITProgressRunner',
	#instVars : [
		'titles'
	],
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'running' }
PhLRecordingProgressRunner >> run: aProgress [

	self titles add: aProgress title.
	^ super run: aProgress
]

{ #category : 'accessing' }
PhLRecordingProgressRunner >> titles [

	^ titles ifNil: [ titles := OrderedCollection new ]
]
