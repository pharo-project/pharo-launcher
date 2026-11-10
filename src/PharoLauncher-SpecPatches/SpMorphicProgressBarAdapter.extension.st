Extension { #name : 'SpMorphicProgressBarAdapter' }

{ #category : '*PharoLauncher-SpecPatches-ProgressBarLabelHeight' }
SpMorphicProgressBarAdapter >> applyStyle: morph [
	"this will apply general properties to the built morph"

	super applyStyle: morph.
	self labelStyle applyTo: progressLabel.
	"The label style inherits the height of the application style: keep the room for the bar"
	progressLabel fitContents.
	self barStyle applyTo: progressBar
]
