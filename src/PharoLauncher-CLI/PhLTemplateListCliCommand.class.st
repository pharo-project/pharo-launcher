"
I represent Pharo Template list sub-command invoked from cmd line of Pharo Launcher. My responsibility is to list local templates. 

I declare: 
- optional flag for stonOutput

I execute:
- list local images with detailed information about image name, used VM, architecture, local dir, etc.
"
Class {
	#name : #PhLTemplateListCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLTemplateListCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	aCommandSpec  
		addFlag: #templateCategory
		description: 'Specifies the template category name to list image templates from given category.'
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | 'Official distributions' ]].
	self addPrintFlagsTo: aCommandSpec
]

{ #category : #'command line - converting' }
PhLTemplateListCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #list 
]

{ #category : #'command line - description' }
PhLTemplateListCliCommand class >> launcherCmdDescription [

	^ 'Prints list of image templates.'
]

{ #category : #'command execution' }
PhLTemplateListCliCommand >> basicExecute [ 
	| templateCategory |
	[ templateCategory := self templateRepository
		categoryNamed: self templateCategory ]
		on: NotFound
		do: [ ^ self raiseCategoryNotFound: self templateCategory ].

	self list: templateCategory templatesAndGroups asOrderedCollection
]

{ #category : #message }
PhLTemplateListCliCommand >> messageErrorCategoryNotFound [
	self errorStream nextPutAll: 'Image template category not found. Please enter a correct image tamplate category name.'.
	self errorStream newLine.
	^ self
]

{ #category : #'error signalling' }
PhLTemplateListCliCommand >> raiseCategoryNotFound: categoryName [

	^ NotFound signal: ('Image template category ''{1}'' not found. Please enter a correct image tamplate category name.' format: { categoryName })
]

{ #category : #'command execution' }
PhLTemplateListCliCommand >> templateCategory [

	^ self positional: #templateCategory
]
