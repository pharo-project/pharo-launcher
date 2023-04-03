"
I define a Pharo Launcher command-line spec and provide a specific context with a Pharo Launcher model.
"
Class {
	#name : #PhLClapCommandSpec,
	#superclass : #ClapCommandSpec,
	#category : #'PharoLauncher-CLI-Model'
}

{ #category : #activating }
PhLClapCommandSpec >> activation [
	^ PhLCliClapContext specification: self
]
