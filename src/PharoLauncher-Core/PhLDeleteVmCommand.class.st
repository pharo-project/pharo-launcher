"
Remove a VM from the hard disk. Can be applied to multiple VMs at the same time.
"
Class {
	#name : #PhLDeleteVmCommand,
	#superclass : #PhLVmCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLDeleteVmCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallDeleteIcon;
		shortcutKey: $x meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PhLDeleteVmCommand >> execute [
	| vms vmNames confirmMessage answer |
	vms := self vmsPresenter selectedVms.
	vmNames := vms collect: #name.
	confirmMessage := 'Are you sure you want to delete VM ' , (vmNames joinUsing: ', ' last: ' and ').
	answer := self vmsPresenter newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer ifFalse: [ ^ self ].
	
	vms do: #removeFromSystem.
	self vmsPresenter refresh.
]

{ #category : #initialization }
PhLDeleteVmCommand >> initialize [
	super initialize.
	self
		name: 'Delete';
		description: 'Delete the selected Pharo Virtual Machines'
]
