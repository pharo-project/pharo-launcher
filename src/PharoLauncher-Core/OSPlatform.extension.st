Extension { #name : #OSPlatform }

{ #category : #'*PharoLauncher-Core' }
OSPlatform class >> archX86_64 [
	^ 'x86_64'
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
OSPlatform >> uname [
	self subclassResponsibility
]
