Extension { #name : #UnixPlatform }

{ #category : #'*PharoLauncher-Core' }
UnixPlatform >> hostArchitecture [
	^ (LibC resultOfCommand: 'uname -m') trim
]

{ #category : #'*PharoLauncher-Core' }
UnixPlatform >> uname [
	^ PhLVmProvider osLinux 
]
