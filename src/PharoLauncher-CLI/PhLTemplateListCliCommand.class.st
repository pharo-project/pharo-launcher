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

{ #category : #'command line - converting' }
PhLTemplateListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #list 
]

{ #category : #'command line - arguments' }
PhLTemplateListCliCommand class >> launcherCmdFlags [
	^ Array 
		with: ((ClapFlag id: #templateCategory)
			description: 'Specifies the template category name to list the image templates from given category.';
			meaning: [ :arg :app | (arg at: #templateCategoryName) word ];
			implicitMeaning: [ :arg :app | 'Official distributions' ];
			add:
				((ClapPositional id: #templateCategoryName)
					description: 'Name of the template category.';
					meaning: [ :pos | pos word asSymbol ];
					implicitMeaning: [ :arg :app | app ]);
			yourself)
		withAll: self printFlags
]

{ #category : #'command execution' }
PhLTemplateListCliCommand >> execute [
	| templateCategory |
	[ templateCategory := self templateRepository
		categoryNamed: self templateCategory ]
		on: NotFound
		do: [ ^ self messageErrorCategoryNotFound ].

	self list: templateCategory templatesAndGroups asOrderedCollection 
]

{ #category : #message }
PhLTemplateListCliCommand >> messageErrorCategoryNotFound [
	self errorStream nextPutAll: 'Image template category not found. Please enter a correct image tamplate category name.'.
	self errorStream newLine.
	^ self
]

{ #category : #'command execution' }
PhLTemplateListCliCommand >> templateCategory [
  ^ (arguments at: #templateCategory) value: self
]
