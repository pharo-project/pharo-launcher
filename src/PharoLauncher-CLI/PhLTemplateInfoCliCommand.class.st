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
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line - converting' }
PhLTemplateInfoCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #info 
	 
]

{ #category : #'command line - arguments' }
PhLTemplateInfoCliCommand class >> launcherCmdFlags [

	^ {(ClapFlag id: #templateCategory)
				description: 'Allows to use a template categroy to search the target template ';
				meaning: [  :arg :app | (arg at: #templateCategoryName) word ];
				implicitMeaning: [  :arg :app | 'Official distributions'. ];
				add: ((ClapPositional id: #templateCategoryName)
					description: 'Name of the template category variable.';
					meaning: [ :pos | pos word asSymbol halt. ];
					implicitMeaning: [  :arg :app | app halt. ])}
]

{ #category : #'command line - arguments' }
PhLTemplateInfoCliCommand class >> launcherCmdPositionals [

	^ {
		((ClapPositional id: #templateName)
				description: 'New image.';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'one argument is missing' .  ];
					yourself).	}
]

{ #category : #'command execution' }
PhLTemplateInfoCliCommand >> execute [
	[ self infoTemplate ]
		on: NotFound
		do: [ self errorMessageWrongTemplateName ]
]

{ #category : #initialization }
PhLTemplateInfoCliCommand >> infoTemplate [
	| template |
	template := self templateRepository
		templateNamed: self templateName
		inCategoryNamed: self templateCategory.
	self outStream
		nextPutAll: template url asString;
		newLine
]

{ #category : #accessing }
PhLTemplateInfoCliCommand >> templateCategory [
  ^ (arguments at: #templateCategory) value: self
]
