"
A class to manage display of progress within a `PhLCurrentContext`.

The work is run by an `ITProgress`: the current `ITProgressRunner` decides how the progress is displayed (Spec window, console progress bar, nothing).
The work block receives a job to report its progress (#title:, #label:, #max:, #currentValue:, #progress:).
"
Class {
	#name : 'PhLProgressManager',
	#superclass : 'Object',
	#category : 'PharoLauncher-Core-Download',
	#package : 'PharoLauncher-Core',
	#tag : 'Download'
}

{ #category : 'i/o' }
PhLProgressManager class >> displayProgress: aTitle during: aBlock [

	^ self new
		displayProgress: aTitle
		during: aBlock
]

{ #category : 'i/o' }
PhLProgressManager >> displayProgress: aTitle during: workBlock [
	"Inform user about download progression.
	The runner may run the work in another process: keep the current context"

	| context |
	context := PhLCurrentContext value.
	^ ITProgress new
		title: aTitle;
		block: [ :job |
			PhLCurrentContext use: context during: [
				[ workBlock cull: job ]
					on: HTTPProgress
					do: [ :progress |
						job label: progress printString.
						progress isEmpty
							ifFalse: [ job progress: progress percentage / 100 ].
						progress resume ] ] ];
		run
]
