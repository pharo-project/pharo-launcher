Extension { #name : #PhLVirtualMachine }

{ #category : #'*PharoLauncher-CLI' }
PhLVirtualMachine >> cliPrintOn: aStream [
	aStream nextPutAll: self id
]

{ #category : #'*PharoLauncher-CLI' }
PhLVirtualMachine class >> listPrintAttributeBlocks [
	
	^ {[:vm | vm isValid ifTrue: ['Yes'] ifFalse: ['No']].[:vm | vm id]. [:vm | vm lastUpdateTimeDescription]. [:vm | vm downloadUrl].}
]

{ #category : #'*PharoLauncher-CLI' }
PhLVirtualMachine class >> listPrintAttributeLabels [
	
	^ {'Is valid'. 'Name'. 'Last update'. 'Download URL'}
]
