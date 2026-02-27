"
A class to manage display of progress within a `PhLCurrentContext`
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

{ #category : 'private' }
PhLProgressManager >> application [

	^ self context application
]

{ #category : 'private' }
PhLProgressManager >> context [

	^ PhLCurrentContext value
]

{ #category : 'i/o' }
PhLProgressManager >> displayProgress: aTitle during: aBlock [
	"Inform user about download progression"
	| presenter job window sem |

	sem := Semaphore new.
	job := self newJobFor: aTitle do: aBlock.
	presenter := self context instantiate: SpJobPresenter on: job. 

	window := presenter asWindow 
		owner: self context window;
		whenOpenedDo: [
			"I need to fork it because otherwise the http request breaks the flow"
			[ job run ] fork ];
		whenClosedDo: [ sem signal ];
		yourself.

	job 
		installOn: presenter announcer;
		whenChangedDo: [ presenter updatePresenter ];
		whenEndDo: [ window close ].
	
	"I can't use whenStartDo: to open the job because is a modal"		
	window open.
	sem wait
]

{ #category : 'private' }
PhLProgressManager >> newJobFor: aTitle do: workBlock [
	| context |
	
	context := self context.
	^ SpJob 
		newTitle: aTitle 
		block: [ :bar |
			PhLCurrentContext 
				use: context
				during: [  
					[ workBlock cull: bar ]
						on: HTTPProgress
						do: [ :progress |
							bar label: progress printString.
							progress isEmpty
								ifFalse: [ bar progressPercent: progress percentage ].
							progress resume ] ] ]
]
