"
Open your OS's file browser on the selected VM directory.
"
Class {
	#name : #PhLShowVmInFolderCommand,
	#superclass : #PhLVmCommand,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLShowVmInFolderCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #openIcon;
		shortcutKey: $o meta;
		yourself
]

{ #category : #executing }
PhLShowVmInFolderCommand >> execute [
	| vms |
	vms := self vmsPresenter selectedVms.
	vms size >= 1
		ifTrue: [ vms first showInFolder ]
]

{ #category : #initialization }
PhLShowVmInFolderCommand >> initialize [
	super initialize.
	self name: 'Show in Folder'
]
