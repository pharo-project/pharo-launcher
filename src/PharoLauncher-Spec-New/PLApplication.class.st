Class {
	#name : #PLApplication,
	#superclass : #SpecApplication,
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #activation }
PLApplication class >> applicationName [

	^ 'launcher'
]

{ #category : #accessing }
PLApplication >> imageRepository [

	^ PhLDirectoryBasedImageRepository default
]

{ #category : #'as yet unclassified' }
PLApplication >> prepareAsStandaloneApplication [

	self useBackend: #Gtk with: PLApplicationConfiguration new
]

{ #category : #running }
PLApplication >> start [ 
	<script: 'self new start'>
	
	(PLMainWindow 
		newApplication: self 
		model: self imageRepository)
		openWithSpec
]
