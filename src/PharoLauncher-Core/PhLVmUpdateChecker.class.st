"
I check if an update is available for the installed virtual machines, and record their version. The result is stored in the folder of each virtual machine (see `PhLVmMetadata`), where the VM manager and the command line read it.
When the check for updates is disabled in the settings, the server is not asked but versions are still recorded.
I announce `PhLVmUpdateCheckDone` on `PhLVmUpdateAnnouncer default` once a check is done.

The virtual machines to update are the installed ones for which the last check found an update.

```
checker := PhLVmUpdateChecker new.
checker check.
checker vmsToUpdate
```
"
Class {
	#name : 'PhLVmUpdateChecker',
	#superclass : 'Object',
	#classVars : [
		'ShouldRun'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

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
			'Check if an update is available for the installed virtual machines (needs internet access)'
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

	self class shouldRun
		ifTrue: [ self installedVms do: [ :vm | vm checkForUpdate ] ]
		ifFalse: [ self installedVms do: [ :vm | vm refreshVersion ] ].
	self announcer announce: PhLVmUpdateCheckDone new
]

{ #category : 'accessing' }
PhLVmUpdateChecker >> vmsToUpdate [
	"Answer the installed VMs for which the last check found an update. The server is not asked."

	^ self installedVms select: [ :vm | vm isUpdateAvailable ]
]

{ #category : 'private' }
PhLVmUpdateChecker >> installedVms [

	^ PhLVirtualMachineManager new availableVirtualMachines values select: [ :vm | vm isValid ]
]

