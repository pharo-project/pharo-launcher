Class {
	#name : #PhLTemplateSourcesUrlCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLTemplateSourcesUrlCliCommandTest >> testTemplateSourcesUrl [
	
	self runCommand: #('launcher' 'template' 'sourcesUrl').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring: 'Pharo 9.0 - 32bit (development version, latest): https://files.pharo.org/image/90/latest-32.zip')
]
