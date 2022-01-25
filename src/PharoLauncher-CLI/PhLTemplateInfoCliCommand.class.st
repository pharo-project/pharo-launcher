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

{ #category : #'command line - converting' }
PhLTemplateInfoCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #info 
	 
]

{ #category : #'command line - arguments' }
PhLTemplateInfoCliCommand class >> launcherCmdFlags [

	^ {(ClapFlag id: #templateCategory)
				description: 'Specifies the template category name to list image templates.';
				meaning: [  :arg :app | (arg at: #templateCategoryName) word ];
				implicitMeaning: [  :arg :app | 'Official distributions'. ];
				add: ((ClapPositional id: #templateCategoryName)
					description: 'Name of the template category.';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [  :arg :app | app . ])}
]

{ #category : #'command line - arguments' }
PhLTemplateInfoCliCommand class >> launcherCmdPositionals [

	^ {
		((ClapPositional id: #templateName)
				description: 'Specifies the template name to print information.';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'An argument is missing, please specify the template name to print iformation.'];
					yourself).	}
]

{ #category : #'command execution' }
PhLTemplateInfoCliCommand >> execute [
	[ self infoTemplate ]
		on: NotFound
		do: [ self logWrongTemplateName ]
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
