"
I am an external drop handler that matches every dropped file, whatever its name or extension. The launcher registers me last so that dropped image folders reach it, and the other drops go on to the usual service chooser.
"
Class {
	#name : 'PhLCatchAllDropHandler',
	#superclass : 'ExternalDropHandler',
	#category : 'PharoLauncher-Spec2-Application',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Application'
}

{ #category : 'testing' }
PhLCatchAllDropHandler >> matchesExtension: anExtension [

	^ true
]
