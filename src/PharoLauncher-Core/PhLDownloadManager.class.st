"
I present a simple interface to an HTTP library.

My semaphore takes care of error handling when multiple downloads occur in parallel.
"
Class {
	#name : 'PhLDownloadManager',
	#superclass : 'Object',
	#instVars : [
		'errors',
		'semaphore'
	],
	#classVars : [
		'Default'
	],
	#category : 'PharoLauncher-Core-Download',
	#package : 'PharoLauncher-Core',
	#tag : 'Download'
}

{ #category : 'accessing' }
PhLDownloadManager class >> default [
	^ Default ifNil: [ self setDefault: self new ]
]

{ #category : 'action' }
PhLDownloadManager class >> reset [
	Default := nil
]

{ #category : 'accessing' }
PhLDownloadManager class >> setDefault: aDownloadManager [
	^ Default := aDownloadManager
]

{ #category : 'private - accessing' }
PhLDownloadManager >> application [

	^ self context application
]

{ #category : 'actions' }
PhLDownloadManager >> basicDownload: url toFile: destinationFile [

	| tmpFile |
	tmpFile := destinationFile , UUID new asString.
	self
		displayProgress: ('Downloading {1}...' format: { url })
		during: [ (self newHTTPClientForUrl: url) downloadTo: tmpFile ].
	destinationFile ensureDelete.
	tmpFile renameTo: destinationFile basename
]

{ #category : 'private - accessing' }
PhLDownloadManager >> context [

	^ PhLCurrentContext value
]

{ #category : 'private' }
PhLDownloadManager >> displayProgress: aTitle during: workBlock [
	"Inform user about download progression"
	| presenter job window |

	job := self newJobFor: aTitle do: workBlock.
	presenter := self context instantiate: SpJobPresenter on: job. 

	window := presenter asModalWindow 
		owner: self context window;
		withoutButtons;
		whenOpenedDo: [
			"I need to fork it because otherwise the http request breaks the flow"
			[ job run ] fork ];
		yourself.

	job 
		installOn: presenter announcer;
		whenChangedDo: [ presenter updatePresenter ];
		whenEndDo: [ 
			window beOk.
			window close ].
	
	"I can't use whenStartDo: to open the job because is a modal"		
	window open
]

{ #category : 'private' }
PhLDownloadManager >> displayProgressDuring: workBlock [
	"Inform user about download progression"

	self 
		displayProgress: 'Downloading...' 
		during: workBlock
]

{ #category : 'actions' }
PhLDownloadManager >> download: url toFile: destinationFile [

	[ self basicDownload: url toFile: destinationFile ]
	on: PhLDownloadError 
	do: [ :error |
			(PhlRetryPresenter new
				application: self application;
				explanation: error longDescription;
				retryBlock: [ self download: url toFile: destinationFile ];
				cancelBlock: [ error pass ];
				asModalWindow) 
					owner: self context window;
					open. ]
]

{ #category : 'private' }
PhLDownloadManager >> downloadFailureForUrl: url message: errorMessage [

	semaphore critical: [ errors add: url ].
	PhLDownloadError signalUrl: url message: errorMessage.
]

{ #category : 'actions' }
PhLDownloadManager >> downloadToPositionableStream: url mimeType: mimeType [
	"Unfortunately, Zinc (and HTTP in general) doesn't support positionable streams so well. So we have to get the whole content as a collection and stream over it."
	| client content |
	
	client := (self newHTTPClientForUrl: url)
		beOneShot;
		accept: mimeType;
		enforceAcceptContentType: true.
	
	self 
		displayProgress: ('Downloading {1}...' format: { url }) 
		during: [ content := client get ].
	
	^ content readStream
]

{ #category : 'initialization' }
PhLDownloadManager >> initialize [
	super initialize.
	semaphore := Semaphore forMutualExclusion.
	errors := OrderedCollection new asValueHolder.
	self reset
]

{ #category : 'private' }
PhLDownloadManager >> newHTTPClientForUrl: url [
	
	^ ZnClient new
		signalProgress: true;
		url: url;
		enforceHttpSuccess: true;
		withOptions: [ :options | options at: #queryKeyValueSafeSet put: (ZnOptions queryKeyValueSafeSet \ '/;') ];
		ifFail: [ :exception | self downloadFailureForUrl: url message: exception messageText ];
		yourself
]

{ #category : 'private' }
PhLDownloadManager >> newJobFor: aTitle do: workBlock [
	
	^ SpJob 
		newTitle: aTitle 
		block: [ :bar |
			workBlock
				on: HTTPProgress
				do: [ :progress |
					bar label: progress printString.
					progress isEmpty
						ifFalse: [ bar progressPercent: progress percentage ].
					progress resume ] ]
]

{ #category : 'accessing' }
PhLDownloadManager >> numberOfErrors [
	^ errors size
]

{ #category : 'actions' }
PhLDownloadManager >> reset [

	errors removeAll
]

{ #category : 'announcements' }
PhLDownloadManager >> whenErrorAddedDo: aBlock [
	errors whenChangedDo: aBlock 

]
