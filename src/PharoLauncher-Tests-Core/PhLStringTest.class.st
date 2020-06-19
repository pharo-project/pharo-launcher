Class {
	#name : #PhLStringTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #tests }
PhLStringTest >> testCanformatTemplateNameFromComplexUrl [
	| result |
	result := '{6} ({5})' formatTemplateName: '/pharo-ide/TelePharo/releases/download/v0.4.2/Pharo7.0-32bit-TelePharo.zip'.
	
	self
		assert: result
		equals: 'Pharo7.0-32bit-TelePharo (v0.4.2)'
]

{ #category : #tests }
PhLStringTest >> testCanformatTemplateNameFromComplexUrl2 [
	| result |
	result := '{1}-{2}-{3}-{5}' formatTemplateName: '/pharo-ide/TelePharo/releases/download/v0.4.2/Pharo7.0-32bit-TelePharo.zip'.
	
	self
		assert: result
		equals: 'pharo-ide-TelePharo-releases-v0.4.2'
]

{ #category : #tests }
PhLStringTest >> testCanformatTemplateNameFromSimpleUrl [
	| result |
	result := '{1}' formatTemplateName: '/foo.zip'.
	
	self
		assert: result
		equals: 'foo'
]

{ #category : #tests }
PhLStringTest >> testFormatTemplateNameDoesNotSubsituteWhenNoSubstitutionPatternFound [
	| result |
	result := 'foo-bar-1' formatTemplateName: '/pharo-ide/TelePharo/releases/download/v0.4.2/Pharo7.0-32bit-TelePharo.zip'.
	
	self
		assert: result
		equals: 'foo-bar-1'
]
