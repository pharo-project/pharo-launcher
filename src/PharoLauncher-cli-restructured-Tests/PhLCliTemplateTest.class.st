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
	self assert: output equals: 'foo[
'.
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
	self assert: output equals: 'Local test templates Template group
Remote test templates Template group
'
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
	self assert: output equals:'memory:///[
'
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
	self assert: output equals: 'Pharo 9.0 - 32bit (development version, latest): https://files.pharo.org/image/90/latest-32.zip
Pharo 9.0 - 64bit (development version, latest): https://files.pharo.org/image/90/latest-64.zip
Pharo 8.0 - 32bit (stable): https://files.pharo.org/image/80/stable-32.zip
Pharo 8.0 - 64bit (stable): https://files.pharo.org/image/80/stable-64.zip
Pharo 7.0 - 32bit (old stable): https://files.pharo.org/image/70/stable-32.zip
Pharo 7.0 - 64bit (old stable): https://files.pharo.org/image/70/stable-64.zip
Moose Suite 9.0 (development): https://github.com/moosetechnology/Moose/releases/download/continuous/Moose9-development.zip
Moose Suite 8.0 (stable): https://github.com/moosetechnology/Moose/releases/download/v8.x.x/Moose8-stable.zip
'
]
