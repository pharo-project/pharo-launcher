"
A PhLImageProcessTest is a test class for testing the behavior of PhLImageProcess
"
Class {
	#name : #PhLImageProcessTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #private }
PhLImageProcessTest >> imagePathNameCandidates [

	|paths delimiter| 
	paths := OrderedCollection new.
	delimiter := FileSystem disk delimiter.
	
	paths add: (String streamContents: [:aStream | 
		aStream nextPutAll:  'some';
			nextPut: delimiter;
			nextPutAll: 'very';
			nextPut: delimiter;
			nextPutAll: 'long';
			nextPut: delimiter;
			nextPutAll: 'path';
			nextPut: delimiter;
			nextPutAll: 'myImage1.image'
		]
	).
	paths add: 'myImage2.image'.
	^ paths
]

{ #category : #tests }
PhLImageProcessTest >> testImageName [

	| imageNames |
	imageNames := self imagePathNameCandidates collect: [:aPath |
		PhLImageProcess new
			imagePath: aPath;
			imageName 
	].
	self assert: (imageNames includesAll: #('myImage1' 'myImage2')).
]

{ #category : #tests }
PhLImageProcessTest >> testNewFrom [

	|imgProcess|
	imgProcess := PhLImageProcess newFrom: '1111 path/to/vm/pharo path/to/1st.image May 1 2023'.
	self assert: imgProcess pid equals: '1111'.
	self assert: imgProcess imageName equals: '1st'.
	self assert: imgProcess vmPath equals: 'path/to/vm/pharo'.
	self assert: imgProcess imagePath equals: 'path/to/1st.image'.
]
