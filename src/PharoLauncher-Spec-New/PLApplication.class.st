Class {
	#name : #PLApplication,
	#superclass : #SpecApplication,
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #accessing }
PLApplication >> imageRepository [

	^ PhLDirectoryBasedImageRepository default
]

{ #category : #running }
PLApplication >> start [ 
	<script: 'self new start'>
	
	(PLMainWindow 
		newApplication: self 
		model: self imageRepository)
		openWithSpec
]
