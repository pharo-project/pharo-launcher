"
Will update selected Virtual Machines. Update will download and install the lastest available archive for the selected VM.
Selected VMs already up to date are skipped.
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

	| selectedVms vmsToUpdate errors |
	selectedVms := self vmsPresenter selectedVms.
	vmsToUpdate := selectedVms select: [ :each | each needsUpdate ].
	PhLCurrentContext
		use: self context
		during: [ errors := PhLVirtualMachine updateAll: vmsToUpdate ].
	self vmsPresenter refresh.
	self showErrors: errors upToDateVms: (selectedVms copyWithoutAll: vmsToUpdate)
]

{ #category : 'initialization' }
PhLUpdateVmCommand >> initialize [
	super initialize.
	self name: 'Update'
]

{ #category : 'private' }
PhLUpdateVmCommand >> showErrors: errors upToDateVms: upToDateVms [

	| messages |
	messages := (errors collect: [ :each | each longDescription ]) asOrderedCollection.
	upToDateVms ifNotEmpty: [
		messages add: 'Already up to date: ' , (', ' join: (upToDateVms collect: [ :each | each id ])) ].
	messages ifEmpty: [ ^ self ].
	self vmsPresenter newInformation
		title: (errors ifEmpty: [ 'Update' ] ifNotEmpty: [ errors first name ]);
		message: (String cr join: messages);
		inform
]
