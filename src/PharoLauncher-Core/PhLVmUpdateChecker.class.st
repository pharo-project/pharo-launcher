"
I check if an update is available for the virtual machines used by the images of an image repository, and announce the virtual machines to update with a PhLVmUpdatesAvailable.

```
checker := PhLVmUpdateChecker imageRepository: anImageRepository.
checker announcer when: PhLVmUpdatesAvailable do: [ :announcement | announcement vms ] for: self.
checker check
```
"
Class {
	#name : 'PhLVmUpdateChecker',
	#superclass : 'Object',
	#instVars : [
		'imageRepository',
		'announcer'
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

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'actions' }
PhLVmUpdateChecker >> check [

	self class shouldRun ifFalse: [ ^ self ].
	self vmsToUpdate ifNotEmpty: [ :vms |
		self announcer announce: (PhLVmUpdatesAvailable vms: vms) ]
]

{ #category : 'initialization' }
PhLVmUpdateChecker >> setImageRepository: anImageRepository [

	imageRepository := anImageRepository
]

{ #category : 'private' }
PhLVmUpdateChecker >> usedVms [
	"A VM is considered as used when an image has its Pharo version."

	| usedPharoVersions |
	usedPharoVersions := imageRepository images
		                     collect: [ :image | image pharoVersion ]
		                     as: Set.
	^ PhLVirtualMachineManager new availableVirtualMachines values select: [ :vm |
		  usedPharoVersions includes: vm pharoVersion ]
]

{ #category : 'private' }
PhLVmUpdateChecker >> vmsToUpdate [

	^ self usedVms select: [ :vm | vm isUpdateAvailable ]
]
