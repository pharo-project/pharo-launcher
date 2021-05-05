"
Usefull only to run the tests. Indeed each users have not the same Images on their drive so we create a ""fake directory"" containing fake ""images"" on prder to always have the same tests.
"
Class {
	#name : #PhLMockImageRepository,
	#superclass : #Object,
	#category : #'PharoLauncher-CLI'
}

{ #category : #instance }
PhLMockImageRepository >> add: aString [ 
	self images add: aString.
]

{ #category : #accessing }
PhLMockImageRepository >> images [

  ^ OrderedCollection streamContents: [ :s | s nextPut: (PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference )]
]

{ #category : #accessing }
PhLMockImageRepository >> moreImages [
  | tempMockImage |
  tempMockImage := OrderedCollection new.
  tempMockImage add: 'blabal'.
  ^ OrderedCollection streamContents: [ :s | s nextPut: (PhLImage location: 'asdsadaasdsad/Pharo 8.0 - 64bit (stable).image' asFileReference ).
	                                          s nextPut: (PhLImage location: 'asdsadaasdsad/Pharblablao 8.0 - 64bit (stable).image' asFileReference ) ]
]
