Class {
	#name : #PLApplication,
	#superclass : #SpecApplication,
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #running }
PLApplication >> start [ 
	<script: 'self new start'>
	
	(PLMainWindow 
		newApplication: self 
		model: PhLDirectoryBasedImageRepository default)
		openWithSpec
]
