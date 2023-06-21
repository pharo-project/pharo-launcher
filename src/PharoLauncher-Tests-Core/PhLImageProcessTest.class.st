"
A PhLImageProcessTest is a test class for testing the behavior of PhLImageProcess
"
Class {
	#name : #PhLImageProcessTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #tests }
PhLImageProcessTest >> testNewFrom [

	|imgProcess|
	imgProcess := PhLImageProcess newFrom: ('1111-|-path/to/vm-|-path/to/1st.image-|-May 1 2023' splitOn: '-|-').
	self assert: imgProcess pid equals: '1111'.
	self assert: imgProcess imageName equals: '1st'.
	self assert: imgProcess vmPath equals: 'path/to/vm'.
	self assert: imgProcess imagePath equals: 'path/to/1st.image'.
	self assert: imgProcess startDateTime equals: 'May 1 2023'.
]
