"
Signals that a newer version of some installed virtual machines is available. The UI decides whether to apply the updates.
"
Class {
	#name : 'PhLVmUpdatesAvailable',
	#superclass : 'Announcement',
	#instVars : [
		'vms'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'instance creation' }
PhLVmUpdatesAvailable class >> vms: aCollection [

	^ self new
		  setVms: aCollection;
		  yourself
]

{ #category : 'initialization' }
PhLVmUpdatesAvailable >> setVms: aCollection [

	vms := aCollection
]

{ #category : 'accessing' }
PhLVmUpdatesAvailable >> vms [

	^ vms
]
