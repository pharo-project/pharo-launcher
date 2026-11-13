"
I specify how a virtual machine tells its version: the one printed by its executable.
"
Class {
	#name : 'PhLVirtualMachineVersionTest',
	#superclass : 'PhLVirtualMachineStoreTest',
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLVirtualMachineVersionTest >> installVmPrinting: aString [
	"Install a VM whose executable is a script printing the given text"

	| vm |
	Smalltalk os isWindows ifTrue: [ ^ self skip ].
	self createVmNamed: '130-x64'.
	vm := PhLVirtualMachine id: '130-x64'.
	self makeExecutableOf: vm print: aString.
	^ vm
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionIsEmptyWhenExecutableCannotBeRun [

	self createVmNamed: '130-x64'.

	self assert: (PhLVirtualMachine id: '130-x64') version equals: ''
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionIsEmptyWhenExecutableDoesNotPrintAVersion [

	| vm |
	vm := self installVmPrinting: 'Usage: pharo [<option>...] [<imageName> [<argument>...]]'.

	self assert: vm version equals: ''
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionIsTheOnePrintedByTheExecutable [

	| vm |
	vm := self installVmPrinting: 'Pharo v10.3.12 built on Oct 23 2026 12:16:05 Compiler: Apple LLVM 12.0.5'.

	self assert: vm version equals: '10.3.12'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionOfVmNotPrintingItsNameFirst [
	"VMs until Pharo 8"

	| vm |
	vm := self installVmPrinting: '5.0 5.0.202002121007 Mac OS X built on Feb 12 2020 10:23:42 UTC'.

	self assert: vm version equals: '5.0.202002121007'
]

{ #category : 'tests' }
PhLVirtualMachineVersionTest >> testVersionWithoutPrefix [
	"VMs of Pharo 9 and 10"

	| vm |
	vm := self installVmPrinting: 'Pharo 9.0.22 built on Mar 30 2023 13:06:13 Compiler: Apple LLVM 12.0.5'.

	self assert: vm version equals: '9.0.22'
]
