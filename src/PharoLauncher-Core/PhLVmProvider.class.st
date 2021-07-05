"
https://files.pharo.org/vm/pharo-spur64/

OS:
Linux, Windows, and Darwin for macOS
"
Class {
	#name : #PhLVmProvider,
	#superclass : #Object,
	#instVars : [
		'vmManager'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #'as yet unclassified' }
PhLVmProvider class >> for: aPhLVirtualMachineManager [ 
	| class |
	class := aPhLVirtualMachineManager pharoVersion asInteger < 90
		ifTrue: [ PhLVmProviderUntilPharo80 ]
		ifFalse: [ self ].
	
	^ class new
		vmManager: aPhLVirtualMachineManager;
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
	^ self urlForPharo: vmManager pharoVersion stable: true
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

{ #category : #'private - accessing' }
PhLVmProvider >> urlTemplate [

	^ 'https://files.pharo.org/get-files/{IMAGE_VERSION}/pharo-vm-{HOST_OS}-{HOST_ARCH}-{VM_STATUS}.zip'
]

{ #category : #initialization }
PhLVmProvider >> vmManager: aPhLVirtualMachineManager [ 
	vmManager := aPhLVirtualMachineManager
]
