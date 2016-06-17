as yet unclassified
vm40Path
	| path |
	
	path := self resourcesPath  / 'vm' / '40'.
	Smalltalk os isMacOSX 
		ifTrue: [ path := path / 'Pharo.app' / 'Contents' / 'MacOS' ].
	^ (path / self vmExecutableName) asFileReference