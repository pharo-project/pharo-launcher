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

{ #category : 'private' }
PhLPharoStableImageResource >> copyImageTo: aDirectory [

	| command |
	command := 'cp -R ', self extractionDir fullName surroundedBySingleQuotes , ' ', aDirectory fullName surroundedBySingleQuotes.
	LibC runCommand: command
]

{ #category : 'private' }
PhLPharoStableImageResource >> downloadPharoStableImage [

	imageZipFile := self workingDir / 'stable-64.zip'.
	PhLDownloadManager new
		basicDownload: 'https://files.pharo.org/image/stable/stable-64.zip'
		toFile: imageZipFile
]

{ #category : 'private' }
PhLPharoStableImageResource >> extractPharoImage [
	
	self extractionDir ensureCreateDirectory.
	
	PhLVirtualMachineManager 
		unzip: self imageZipFile 
		to: self extractionDir
]

{ #category : 'private - accessing' }
PhLPharoStableImageResource >> extractionDir [

	^ self workingDir / 'extracted'
]

{ #category : 'private - accessing' }
PhLPharoStableImageResource >> image [
	
	^ image
]

{ #category : 'private - accessing' }
PhLPharoStableImageResource >> imageZipFile [

	^ imageZipFile
]

{ #category : 'running' }
PhLPharoStableImageResource >> newImage [

	^ self newImageIn: self workingDir / (UUID new asString)
]

{ #category : 'running' }
PhLPharoStableImageResource >> newImageIn: imageDir [

	| imageFile |
	self copyImageTo: imageDir.
	imageFile := (imageDir childrenMatching: '*.image') first.
	
	^ PhLImage location: imageFile
]

{ #category : 'running' }
PhLPharoStableImageResource >> newRepositoryWithImage [

	| repositoryDir imageDir newImage |
	repositoryDir := self workingDir / (UUID new asString).
	repositoryDir ensureCreateDirectory.
	imageDir := repositoryDir / 'temp'.
	
	newImage := self newImageIn: imageDir.
	imageDir renameTo: newImage name.
	newImage setLocation: repositoryDir / newImage name / (newImage name, '.image').
	^ newImage
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

{ #category : 'private - accessing' }
PhLPharoStableImageResource >> workingDir [

	^ workingDir
]
