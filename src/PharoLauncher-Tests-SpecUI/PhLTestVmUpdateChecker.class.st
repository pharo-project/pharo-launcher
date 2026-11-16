"
VM update checker for test purposes: I answer the virtual machines to update I was given.
"
Class {
	#name : 'PhLTestVmUpdateChecker',
	#superclass : 'PhLVmUpdateChecker',
	#instVars : [
		'vmsToUpdate'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'instance creation' }
PhLTestVmUpdateChecker class >> vmsToUpdate: virtualMachines [

	^ self new
		  setVmsToUpdate: virtualMachines;
		  yourself
]

{ #category : 'initialization' }
PhLTestVmUpdateChecker >> setVmsToUpdate: virtualMachines [

	vmsToUpdate := virtualMachines
]

{ #category : 'accessing' }
PhLTestVmUpdateChecker >> vmsToUpdate [

	^ vmsToUpdate
]
