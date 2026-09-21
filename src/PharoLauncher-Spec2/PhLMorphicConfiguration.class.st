"
I define the configuration for Pharo Launcher application.
For now, I only define new styles.
"
Class {
	#name : 'PhLMorphicConfiguration',
	#superclass : 'SpMorphicConfiguration',
	#instVars : [
		'activeTheme'
	],
	#category : 'PharoLauncher-Spec2-Application',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Application'
}

{ #category : 'styling' }
PhLMorphicConfiguration >> customStyleSheet [
	^ (SpStyleVariableSTONReader fromString: '.application [       
 	   .greenOnGray [ Draw { #color: #lightGreen} , Draw { #backgroundColor: #gray } ] ]
	')
]

{ #category : 'private - factory' }
PhLMorphicConfiguration >> newStyleSheet [

	^ SpStyle defaultStyleSheet copy, self customStyleSheet
]
