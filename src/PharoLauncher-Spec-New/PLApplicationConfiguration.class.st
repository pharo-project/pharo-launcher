Class {
	#name : #PLApplicationConfiguration,
	#superclass : #SpecApplicationConfiguration,
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #configuring }
PLApplicationConfiguration >> configureOSX: anApplication [

	GtkSettings default themeName: 'Sierra-dark'.
	"GtkSettings default themeName: 'Sierra-light'."

]

{ #category : #configuring }
PLApplicationConfiguration >> configureWindows: anApplication [

	GtkSettings default themeName: 'Windows-10-master'.

]
