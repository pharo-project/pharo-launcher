"
I check if an update is available for the installed virtual machines. The result is stored in the folder of each virtual machine (see `PhLVmMetadata`), where the VM manager and the command line read it.
I announce on `PhLVmUpdateAnnouncer default`:
- `PhLVmUpdatesAvailable` with the virtual machines to update that are used by an image of the image repository, so that the user is proposed to update them,
- `PhLVmUpdateCheckDone` once the check is done.

```
(PhLVmUpdateChecker imageRepository: anImageRepository) check
```
"
Class {
	#name : 'PhLVmUpdateChecker',
	#superclass : 'Object',
	#instVars : [
		'imageRepository'
	],
	#classVars : [
		'ShouldRun'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
PhLVmUpdateChecker class >> imageRepository: anImageRepository [

	^ self new
		  setImageRepository: anImageRepository;
		  yourself
]

{ #category : 'settings' }
PhLVmUpdateChecker class >> settingsOn: aBuilder [

	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #shouldCheckVmUpdate)
		label: 'Check for virtual machines update?';
		groupName: #pharoLauncher;
		target: self;
		getSelector: #shouldRun;
		setSelector: #shouldRun:;
		order: 56;
		description:
			'Check if an update is available for the virtual machines used by images (needs internet access)'
]

{ #category : 'settings' }
PhLVmUpdateChecker class >> shouldRun [

	^ ShouldRun ifNil: [ ShouldRun := true ]
]

{ #category : 'settings' }
PhLVmUpdateChecker class >> shouldRun: aBoolean [

	ShouldRun := aBoolean
]

{ #category : 'accessing' }
PhLVmUpdateChecker >> announcer [

	^ PhLVmUpdateAnnouncer default
]

{ #category : 'actions' }
PhLVmUpdateChecker >> check [

	| vmsToUpdate |
	self class shouldRun ifFalse: [ ^ self ].
	vmsToUpdate := self installedVms select: [ :vm | vm checkForUpdate ].
	(self usedAmong: vmsToUpdate) ifNotEmpty: [ :vms |
		self announcer announce: (PhLVmUpdatesAvailable vms: vms) ].
	self announcer announce: PhLVmUpdateCheckDone new
]

{ #category : 'initialization' }
PhLVmUpdateChecker >> setImageRepository: anImageRepository [

	imageRepository := anImageRepository
]

{ #category : 'private' }
PhLVmUpdateChecker >> installedVms [
	"Only the standard VMs are published on the server"

	^ PhLVirtualMachineManager new availableVirtualMachines values select: [ :vm | vm isUpdatable ]
]

{ #category : 'private' }
PhLVmUpdateChecker >> usedAmong: virtualMachines [
	"A VM is considered as used when an image has its Pharo version."

	| usedPharoVersions |
	usedPharoVersions := imageRepository images
		                     collect: [ :image | image pharoVersion ]
		                     as: Set.
	^ virtualMachines select: [ :vm | usedPharoVersions includes: vm pharoVersion ]
]
