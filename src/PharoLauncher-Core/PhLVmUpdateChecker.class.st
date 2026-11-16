"
I check if an update is available for the installed virtual machines, and record their version. The result is stored in the folder of each virtual machine (see `PhLVmMetadata`), where the VM manager and the command line read it.
When the check for updates is disabled in the settings, the server is not asked but versions are still recorded.
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
	vmsToUpdate := self class shouldRun
		               ifTrue: [ self installedVms select: [ :vm | vm checkForUpdate ] ]
		               ifFalse: [
			               self installedVms do: [ :vm | vm refreshVersion ].
			               #(  ) ].
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

	^ PhLVirtualMachineManager new availableVirtualMachines values select: [ :vm | vm isValid ]
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
