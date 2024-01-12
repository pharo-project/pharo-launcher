Extension { #name : #OSWorldRenderer }

{ #category : #'*PharoLauncher-Spec2' }
OSWorldRenderer >> defaultWindowTitle [

	^ PharoLauncherApplication isDeployed 
		ifTrue: [ 'Pharo Launcher' ]
		ifFalse: [ Smalltalk image imageFile fullName ]
]

{ #category : #'*PharoLauncher-Spec2' }
OSWorldRenderer >> doActivate [
	| attributes initialExtent title |

	initialExtent := world worldState realWindowExtent ifNil: [976@665].

	attributes := OSWindowAttributes new.
	title := PharoLauncherApplication isDeployed 
		ifTrue: [ 'Pharo Launcher' ]
		ifFalse: [ Smalltalk image shortImageName ].
	attributes
		extent: initialExtent;
		title: title;
		windowCentered:true.

	display := Form extent: initialExtent depth: 32.
	world extent: initialExtent.

	driver := self pickMostSuitableWindowDriver.
	attributes preferableDriver: driver.
	osWindow := OSWindow createWithAttributes: attributes eventHandler: (OSWindowMorphicEventHandler for: world).

	driver afterMainPharoWindowCreated: osWindow.
	driver afterSetWindowTitle: title onWindow: osWindow.
	driver startUp: true.

	world worldState doFullRepaint.
	world displayWorld.

	OSWindowClipboard new beDefault.

	"SDL2 on MacOS presented a bug if this message send is done earlier on this method.
	See: https://github.com/pharo-project/pharo/issues/10981"
	osWindow focus
]

{ #category : #'*PharoLauncher-Spec2' }
OSWorldRenderer >> updateWindowTitle [

	"do nothing"
]
