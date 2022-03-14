"
I define the configuration for Pharo Launcher application.
For now, I only define new styles.
"
Class {
	#name : #PharoLauncherConfiguration,
	#superclass : #SpMorphicConfiguration,
	#category : #'PharoLauncher-Spec2'
}

{ #category : #styling }
PharoLauncherConfiguration >> customStyleSheet [
	^ (SpStyleVariableSTONReader fromString: '.application [       
 	   .greenOnGray [ Draw { #color: #lightGreen} , Draw { #backgroundColor: #gray } ] ]
	')
]

{ #category : #'private - factory' }
PharoLauncherConfiguration >> newStyleSheet [

	^ SpStyle defaultStyleSheet copy, self customStyleSheet
]
