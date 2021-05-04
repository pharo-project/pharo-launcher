Class {
	#name : #PhLMockImageRepository,
	#superclass : #Object,
	#category : #'PharoLauncher-CLI'
}

{ #category : #accessing }
PhLMockImageRepository >> images [

  ^ OrderedCollection streamContents: [ :s | s nextPut: (PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference ) ]
]
