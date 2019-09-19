"
Will update selected Virtual Machines. Update will download and install the lastest available archive for the selected VM.
"
Class {
	#name : #PhLUpdateVmCommand,
	#superclass : #PhLVmCommand,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLUpdateVmCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallUpdate;
		shortcutKey: $u meta;
		yourself
]

{ #category : #executing }
PhLUpdateVmCommand >> execute [
	self vmsPresenter selectedVms do: #update.
	self vmsPresenter refresh.
]

{ #category : #initialization }
PhLUpdateVmCommand >> initialize [
	super initialize.
	self basicName: 'Update'
]
