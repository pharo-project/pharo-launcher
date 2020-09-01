Class {
	#name : #PLhGtoolkitImage,
	#superclass : #PhLImage,
	#category : #'PharoLauncher-GToolkit'
}

{ #category : #testing }
PLhGtoolkitImage class >> isClassForLocation: imageFileReference [
	| versionFile |
	versionFile := imageFileReference parent / self versionFileName.
	^ versionFile exists and: [ versionFile contents beginsWith: 'gt-' ]
]

{ #category : #accessing }
PLhGtoolkitImage >> defaultArguments [
	^ super defaultArguments
		add: '--no-quit';
		add: '--interactive';
		yourself
]
