"
I'm used to provide the download URL of the Pharo Virtual Machine described as a PhLVirtualMachine object or a PhLVirtualMachineManager (used to determine VM information from an image file).
"
Class {
	#name : #PhLVmProvider,
	#superclass : #Object,
	#instVars : [
		'vmManager'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #'instance creation' }
PhLVmProvider class >> for: aPhLVirtualMachineOrManager [
	| class |
	class := aPhLVirtualMachineOrManager pharoVersion asInteger < 90
		ifTrue: [ PhLVmProviderUntilPharo80 ]
		ifFalse: [ self ].
	
	^ class new
		vmManager: aPhLVirtualMachineOrManager;
		yourself.
]

{ #category : #'accessing - os' }
PhLVmProvider class >> osDarwin [
	^ 'Darwin'
]

{ #category : #'accessing - os' }
PhLVmProvider class >> osLinux [
	^ 'Linux'
]

{ #category : #'accessing - os' }
PhLVmProvider class >> osWindows [
	^ 'Windows'
]

{ #category : #'accessing - os' }
PhLVmProvider class >> supportedOs [
	^ { self osDarwin . self osLinux . self osWindows }
]

{ #category : #accessing }
PhLVmProvider >> hostArchitecture [
	^ OSPlatform current hostArchitecture
]

{ #category : #accessing }
PhLVmProvider >> hostOS [
	^ OSPlatform current uname
]

{ #category : #accessing }
PhLVmProvider >> url [ 
	^ self urlForStable: true
]

{ #category : #private }
PhLVmProvider >> urlForPharo: pharoVersionNumber stable: useStableVm [ 
	| vmStatus |
	vmStatus := useStableVm ifTrue: [ 'stable' ] ifFalse: [ 'latest' ].
	
	^ self urlTemplate 
		format: (Dictionary 
			with: #IMAGE_VERSION -> pharoVersionNumber
			with: #HOST_OS -> self hostOS
			with: #HOST_ARCH -> self hostArchitecture
			with: #VM_STATUS -> vmStatus)
]

{ #category : #private }
PhLVmProvider >> urlForStable: useStableVm [ 
		
	^ self urlForPharo: vmManager pharoVersion stable: useStableVm 
]

{ #category : #'private - accessing' }
PhLVmProvider >> urlTemplate [

	^ 'https://files.pharo.org/get-files/{IMAGE_VERSION}/pharo-vm-{HOST_OS}-{HOST_ARCH}-{VM_STATUS}.zip'
]

{ #category : #initialization }
PhLVmProvider >> vmManager: aPhLVirtualMachineManager [ 
	vmManager := aPhLVirtualMachineManager
]
