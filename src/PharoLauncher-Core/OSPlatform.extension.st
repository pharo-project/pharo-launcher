Extension { #name : #OSPlatform }

{ #category : #'*PharoLauncher-Core' }
OSPlatform class >> archX86_64 [
	^ 'x86_64'
]

{ #category : #'*PharoLauncher-Core' }
OSPlatform >> architectureOf: aPathString [

	"ensure file is executable and "
	^ LibC resultOfCommand: 'file -b ' , aPathString
]

{ #category : #'*PharoLauncher-Core' }
OSPlatform >> canRun32bitApp [
	^ true
]

{ #category : #'*PharoLauncher-Core' }
OSPlatform >> hostArchitecture [
	self subclassResponsibility
]

{ #category : #'*PharoLauncher-Core' }
OSPlatform >> isValid: aPhLVirtualMachine [
	
	| architecture |
	architecture := $, split: (self architectureOf: aPhLVirtualMachine vmBinaryFullName ).
	architecture := architecture collect: [ :each | each trimBoth ].
	architecture detect: [ :each | each includesSubstring: #executable] ifNone: [ ^ false ].
	
	"64 bits exe and 32-bit PhLVirtualMachine or vice-versa"
	((architecture anySatisfy: [ :each | (each includesSubstring: 'x86-64') or: [each includesSubstring: 'x86_64'] ] ) 
		xor: [ aPhLVirtualMachine is64bit ]) ifTrue: [ ^ false ].
	
	^ true

]

{ #category : #'*PharoLauncher-Core' }
OSPlatform >> uname [
	self subclassResponsibility
]
