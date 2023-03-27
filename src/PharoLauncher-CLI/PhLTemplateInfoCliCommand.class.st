"
I represent Pharo Template source Url sub-command invoked from cmd line of Pharo Launcher. My responsibility is to display the source of officials templates. 

I declare: 
- optional flag for stonOutput

I execute:
- gives the source the templates from the official category
"
Class {
	#name : #PhLTemplateInfoCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLTemplateInfoCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	aCommandSpec  
		addFlag: #templateCategory
		description: 'Specifies the template category name to list image templates.'
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | 'Official distributions' ]]
]

{ #category : #'command line - arguments' }
PhLTemplateInfoCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	(aCommandSpec 
		addPositional: #templateName 
		description: 'Specifies the template name to print information.')
	implicitMeaning: [:arg :app | app raiseMissingTemplateToPrint]
]

{ #category : #'command line - converting' }
PhLTemplateInfoCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #info 
	 
]

{ #category : #'command line - description' }
PhLTemplateInfoCliCommand class >> launcherCmdDescription [

	^ 'Prints information about image template name, origin url.'
]

{ #category : #'error signalling' }
PhLTemplateInfoCliCommand class >> raiseMissingTemplateToPrint [

	^ NotFound signal: 'An argument is missing, please specify the template name to print information.'
]

{ #category : #'command execution' }
PhLTemplateInfoCliCommand >> basicExecute [ 

	self list: (Array with: self findTemplate)
]

{ #category : #accessing }
PhLTemplateInfoCliCommand >> findTemplate [
	
	^	[ self templateRepository
			templateNamed: self templateName
			inCategoryNamed: self templateCategory
		] 
		on: NotFound 
		do: [ self raiseTemplateNotFound: self templateName]
]

{ #category : #'accessing arguments' }
PhLTemplateInfoCliCommand >> printSequence [

	"do not print sequence number for just one template"
	^ false
]

{ #category : #'error signalling' }
PhLTemplateInfoCliCommand >> raiseTemplateNotFound: aTemplateName [

	^ NotFound signal: ('Local image template: ''{1}'' not found. Please enter a correct template name.' format: { aTemplateName })
]

{ #category : #'accessing arguments' }
PhLTemplateInfoCliCommand >> rowMode [

	"template info is printed in one attribute per row"
	^ true
]

{ #category : #'accessing arguments' }
PhLTemplateInfoCliCommand >> templateCategory [
	
	^ self positional: #templateCategory
]
