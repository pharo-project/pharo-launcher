Extension { #name : #SDLOSXPlatform }

{ #category : #'*PharoLauncher-Spec2' }
SDLOSXPlatform >> afterSetWindowTitle: aString onWindow: aOSSDLWindow [

	"Do not set the window title with the document name.
	It will change the app title and the icon."
]
