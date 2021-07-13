Extension { #name : #PhLVirtualMachine }

{ #category : #'*PharoLauncher-CLI' }
PhLVirtualMachine >> cliPrintOn: aStream [
	aStream nextPutAll: self id
]
