"
I'm used to provide the download URL of the Pharo Virtual Machine for Pharo version up to Pharo 8.0.
Pharo versions > 8.0 have a diffrente URL scheme and are managed by PhLVmProvider.
"
Class {
	#name : #PhLVmProviderUntilPharo80,
	#superclass : #PhLVmProvider,
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #accessing }
PhLVmProviderUntilPharo80 >> compatibleUrlForPharo: pharoVersion arch64: is64bit [  
	^ self urlTemplate 
		format: (Dictionary 
			with: #IMAGE_VERSION -> pharoVersion
			with: #IMAGE_ARCH -> (is64bit ifTrue: [ '64' ] ifFalse: [ '' ])
			with: #OS_PATH_SEGMENT -> self downloadPathOSTypeSegment
			with: #VM_FLAVOUR -> ''
			with: #VM_STATUS -> 'stable')
]

{ #category : #'private - accessing' }
PhLVmProviderUntilPharo80 >> downloadPathOSTypeSegment [
	| os |
	os := Smalltalk os.
	(os isMacOS or: [ os isMacOSX ]) ifTrue: [ ^ 'mac' ].	
	os isUnix ifTrue: [ ^ 'linux' ].
	os isWindows ifTrue: [ ^ 'win' ].

]

{ #category : #'private - accessing' }
PhLVmProviderUntilPharo80 >> imageArchitecture [
	" No 64-bit image before Pharo 6.0"
	^ (vmManager is64bit and: [ vmManager pharoVersion > '50' ]) 
		ifTrue: [ '64' ] 
		ifFalse: [ '' ]
]

{ #category : #private }
PhLVmProviderUntilPharo80 >> urlForPharo: pharoVersion stable: useStableVm [ 
	| vmStatus |
	vmStatus := useStableVm ifTrue: [ 'stable' ] ifFalse: [ 'latest' ].
		
	^ self urlTemplate 
		format: (Dictionary 
			with: #IMAGE_VERSION -> pharoVersion
			with: #IMAGE_ARCH -> self imageArchitecture
			with: #OS_PATH_SEGMENT -> self downloadPathOSTypeSegment
			with: #VM_FLAVOUR -> self vmFlavour
			with: #VM_STATUS -> vmStatus)
]

{ #category : #private }
PhLVmProviderUntilPharo80 >> urlForStable: useStableVm [ 
	| pharoVersion |
	pharoVersion  := (vmManager isPreSpur and: [ vmManager imageVersion = '50' ])
		ifTrue: [ '50-preSpur' ]
		ifFalse: [ vmManager pharoVersion ].
		
	^ self urlForPharo: pharoVersion stable: useStableVm 
]

{ #category : #'private - accessing' }
PhLVmProviderUntilPharo80 >> urlTemplate [
	"IMAGE_VERSION (11 .. 70, 80)
	 IMAGE_ARCH (32 or 64)
	 OS_PATH_SEGEMENT (win mac or linux)
	 VM_FLAVOUR? (-headless or empty)
	 VM_STATUS (stable or latest)"
	^ 'https://files.pharo.org/get-files/{IMAGE_VERSION}/pharo{IMAGE_ARCH}-{OS_PATH_SEGMENT}{VM_FLAVOUR}-{VM_STATUS}.zip'
]

{ #category : #'private - accessing' }
PhLVmProviderUntilPharo80 >> vmFlavour [
	^ vmManager flavour
]
