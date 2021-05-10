Class {
	#name : #PhLGtkConfiguration,
	#superclass : #SpGtkConfiguration,
	#category : #'PharoLauncher-Spec2-Gtk'
}

{ #category : #configuring }
PhLGtkConfiguration >> configureGeneral: anApplication [ 

	self addCSSProviderFromString: '
toolbar.compact { 
	font-size: 0.6em }
toolbar.compact toolbutton > button { 
	padding: 2px;
	margin: 2px }
'
]
