"
I provide a stable Pharo image that I only download once.
"
Class {
	#name : 'PhLPharoStableImageResource',
	#superclass : 'TestResource',
	#instVars : [
		'workingDir',
		'imageZipFile',
		'image'
	],
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'fetching' }
PhLPharoStableImageResource >> downloadPharoStableImage [

	imageZipFile := self workingDir / 'stable-64.zip'.
	PhLDownloadManager new
		basicDownload: 'https://files.pharo.org/image/stable/stable-64.zip'
		toFile: imageZipFile
]

{ #category : 'fetching' }
PhLPharoStableImageResource >> extractPharoImage [

	| imageFile |
	PhLVirtualMachineManager 
		unzip: self imageZipFile 
		to: self workingDir.
		
	imageFile := (self workingDir childrenMatching: '*.image') first.
	image := PhLImage location: imageFile.
]

{ #category : 'accessing' }
PhLPharoStableImageResource >> image [
	
	^ image
]

{ #category : 'accessing' }
PhLPharoStableImageResource >> imageZipFile [

	^ imageZipFile
]

{ #category : 'running' }
PhLPharoStableImageResource >> setUp [ 

	workingDir := FileLocator temp / (self className , '-' , UUID new asString).
	workingDir ensureCreateDirectory.
	self downloadPharoStableImage.
	self extractPharoImage
]

{ #category : 'running' }
PhLPharoStableImageResource >> tearDown [ 

	workingDir ensureDeleteAll.
	super tearDown
]

{ #category : 'accessing' }
PhLPharoStableImageResource >> workingDir [

	^ workingDir
]
