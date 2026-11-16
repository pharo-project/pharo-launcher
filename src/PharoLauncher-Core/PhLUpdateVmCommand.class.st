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
	"A VM failing to update is left as it was: the other VMs are still updated."

	| errors |
	errors := OrderedCollection new.
	PhLCurrentContext
		use: self context
		during: [
			self vmsPresenter selectedVms do: [ :each |
				[ each updateFromUrl ]
					on: Error
					do: [ :error | errors add: (PhLVirtualMachineUpdateError vm: each cause: error) ] ] ].
	self vmsPresenter refresh.
	self showErrors: errors
]

{ #category : 'initialization' }
PhLUpdateVmCommand >> initialize [
	super initialize.
	self name: 'Update'
]

{ #category : 'private' }
PhLUpdateVmCommand >> showErrors: errors [

	errors ifEmpty: [ ^ self ].
	self vmsPresenter newInformation
		title: errors first name;
		message: (String cr join: (errors collect: [ :each | each longDescription ]));
		inform
]
