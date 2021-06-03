Class {
	#name : #PhLCliTemplateTest,
	#superclass : #ClapPharoCommandsTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLCliTemplateTest >> testOutputListTemplate [

	| command commandContext model output |
	model := PharoLauncherCLIModel new.
	model templateBaseRepository: PhLTemplateGroupTestRepository new.
	model templateBaseRepository createLocalTemplateNamed:'foo'.
	command := PhLTemplateListCliCommand asCliCommand: model.
	commandContext := command activationWith: {'list'}.
	
	commandContext execute.
	
	output := commandContext stdio stdout contents utf8Decoded. 
	self assert: (output includesSubstring: 'foo').
]

{ #category : #tests }
PhLCliTemplateTest >> testOutputTemplateCategories [

	| command commandContext model output |
	model := PharoLauncherCLIModel new.
	model templateBaseRepository: PhLTemplateGroupTestRepository new.
	model templateBaseRepository createLocalTemplateNamed:'foo'.
	command := PhLTemplateCategoriesCliCommand asCliCommand: model.
	commandContext := command activationWith: {'categories'}.
	
	commandContext execute.
	
	output := commandContext stdio stdout contents utf8Decoded. 
	self assert: (output includesSubstring: 'Local test templates') 
]

{ #category : #tests }
PhLCliTemplateTest >> testOutputTemplateSourcesDir [

	| command commandContext model output |
	model := PharoLauncherCLIModel new.
	model templateBaseRepository: PhLTemplateGroupTestRepository new.
	model templateBaseRepository createLocalTemplateNamed:'foo'.
	command := PhLTemplateSourcesDirCliCommand asCliCommand: model.
	commandContext := command activationWith: {'sourcesDir'}.
	
	commandContext execute.
	
	output := commandContext stdio stdout contents utf8Decoded. 
	self assert: (output includesSubstring: 'memory:///') 
]

{ #category : #tests }
PhLCliTemplateTest >> testOutputTemplateSourcesUrl [

	| command commandContext model output |
	model := PharoLauncherCLIModel new.
	model templateBaseRepository: PhLTemplateGroupTestRepository new.
	model templateBaseRepository createLocalTemplateNamed:'foo'.
	command := PhLTemplateSourcesUrlCliCommand asCliCommand: model.
	commandContext := command activationWith: {'sourcesUrl'}.
	
	commandContext execute.
	
	output := commandContext stdio stdout contents utf8Decoded. 
	self assert: (output includesSubstring: 'Pharo 9.0 - 32bit (development version, latest): https://files.pharo.org/image/90/latest-32.zip')
]
