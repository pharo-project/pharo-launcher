"
Will update selected Virtual Machines. Update will download and install the lastest available archive for the selected VM.
"
Class {
	#name : 'PhLUpdateVmCommand',
	#superclass : 'PhLVmCommand',
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
PhLUpdateVmCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallUpdate;
		shortcutKey: $u actionModifier;
		yourself
]

{ #category : 'executing' }
PhLUpdateVmCommand >> execute [

	PhLCurrentContext 
		use: self context
		during: [ 
			self vmsPresenter selectedVms 
				do: [ :each | each updateFromUrl ] ].
	self vmsPresenter refresh.
]

{ #category : 'initialization' }
PhLUpdateVmCommand >> initialize [
	super initialize.
	self name: 'Update'
]
