Extension { #name : 'SpMorphicWorldAdapter' }

{ #category : '*PharoLauncher-Spec2' }
SpMorphicWorldAdapter >> isTopWindow [
	"The world is the top window when no window of the world is active"

	^ SystemWindow topWindow
		ifNil: [ true ]
		ifNotNil: [ :window | (window world == self widget) not ]
]
