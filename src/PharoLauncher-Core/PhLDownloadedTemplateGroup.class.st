"
I represent a group of templates already downloaded from the network. I maintain a set of zip files in my baseDirectory and a cache.json which contains meta-data about these files.

IMPLEMENTATION

I don't cache anything as variables in the image. For each action, I read the cache.json and update it.
"
Class {
	#name : #PhLDownloadedTemplateGroup,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'name'
	],
	#classVars : [
		'Default'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLDownloadedTemplateGroup class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #'instance creation' }
PhLDownloadedTemplateGroup class >> named: aName [
	^ Default := self new 	
		setName: aName;
		yourself
]

{ #category : #accessing }
PhLDownloadedTemplateGroup >> baseDirectory [
	^ (FileLocator preferences / 'pharo' / 'templateCache') ensureCreateDirectory
]

{ #category : #accessing }
PhLDownloadedTemplateGroup >> cacheFile [	
	^ (self baseDirectory / 'cache', 'json') ensureCreateFile
]

{ #category : #private }
PhLDownloadedTemplateGroup >> dictionary [
	^ self cacheFile
		readStreamDo: [ :aStream | 
			aStream atEnd
				ifTrue: [ Dictionary new ]
				ifFalse: [ STONJSON fromStream: aStream ] ]
]

{ #category : #action }
PhLDownloadedTemplateGroup >> downloadAndStoreFile: anUrl forTemplate: aRemoteTemplate [
	"Download the file at anUrl (hopefully a zip archive), put it in my cache, and update the meta-data file (using information from aRemoteTemplate). If everything went well, a reference to the downloaded file is returned"
	| destinationFile fileExtension |
	"We want to keep the same extension..."
	fileExtension := anUrl lastPathSegment copyAfterLast: $..
	"...but change the file name to be the one of aRemoteTemplate"
	destinationFile := self baseDirectory / aRemoteTemplate name , fileExtension.
	destinationFile ensureDelete.
	PhLDownloadManager default download: anUrl toFile: destinationFile.
	self register: aRemoteTemplate withZip: destinationFile.
	^ destinationFile
]

{ #category : #accessing }
PhLDownloadedTemplateGroup >> name [
	^ name
]

{ #category : #accessing }
PhLDownloadedTemplateGroup >> pharoStableImagePath [
	| img |
	img := (self resourcesPath  / 'images' / 'pharo-stable.zip') asFileReference.
	^ img exists 
		ifTrue: [ img ]
		ifFalse: [ nil ]
]

{ #category : #private }
PhLDownloadedTemplateGroup >> register: aRemoteTemplate withZip: aZipFile [
	"Update my cache file by adding information about a new zip file as described in aRemoteTemplate"
	| aDictionary templateDescription |
	aDictionary := self dictionary.
	templateDescription := aDictionary at: aRemoteTemplate name ifAbsentPut: [ Dictionary new ].
	self updateTemplateDescription: templateDescription with: aRemoteTemplate.
	self saveToFile: aDictionary
]

{ #category : #accessing }
PhLDownloadedTemplateGroup >> resourcesPath [
	| vmDirectory |
	
	vmDirectory := Smalltalk vm binary parent.

	Smalltalk os isMacOSX ifTrue: [ ^ vmDirectory parent / 'Resources' ].
	Smalltalk os isUnix ifTrue: [ ^ vmDirectory parent/ 'shared' ].
	Smalltalk os isWindows ifTrue: [ ^ vmDirectory ].
]

{ #category : #private }
PhLDownloadedTemplateGroup >> saveToFile: aDictionary [
	self cacheFile writeStreamDo: [ :aStream | 	STONJSON put: aDictionary onStream: aStream ] 
]

{ #category : #accessing }
PhLDownloadedTemplateGroup >> setName: aString [ 
	name := aString
]

{ #category : #accessing }
PhLDownloadedTemplateGroup >> templatesAndGroups [
	"Read the cache file to answer a list of already downloaded templates"
	| aDictionary templates |
	templates := SortedCollection sortBlock: [ :e1 :e2 | e1 name < e2 name ].
	aDictionary := self dictionary.
	aDictionary valuesDo: [ :value | 
		(self baseDirectory / (value at: #name), 'zip') exists 
			ifTrue: [ templates add:
			(PhLLocalTemplate 
				name: (value at: #name)
				zipFile: self baseDirectory / (value at: #name), 'zip')  ]
			ifFalse: [ self flag:'TODO remove non existing stuff' ].
		].
	self pharoStableImagePath ifNotNil: [:image | 
		templates add: 
			(PhLLocalTemplate 
				name: 'Pharo image (stable)'
				zipFile: image)
		].
	^ templates
]

{ #category : #private }
PhLDownloadedTemplateGroup >> updateTemplateDescription: templateDescription with: aRemoteTemplate [
	templateDescription at: 'url' put: aRemoteTemplate url asString.
	templateDescription at: 'name' put: aRemoteTemplate name.
	templateDescription at: 'downloadDate' put: DateAndTime now asString
]
