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
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line - converting' }
PhLTemplateListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #list 
]

{ #category : #'command line - arguments' }
PhLTemplateListCliCommand class >> launcherCmdFlags [

	^ {(ClapFlag id: #templateCategory)
				description: 'Allows to use a template categroy to list the templates in it ';
				meaning: [  :arg :app | (arg at: #templateCategoryName) word ];
				implicitMeaning: [  :arg :app | 'Official distributions'. ];
				add: ((ClapPositional id: #templateCategoryName)
					description: 'Name of the template category variable.';
					meaning: [ :pos | pos word asSymbol halt. ];
					implicitMeaning: [  :arg :app | app halt. ])}
					
]

{ #category : #'command execution' }
PhLTemplateListCliCommand >> execute [
	| templateCategory templateRepository |
	templateCategory := self templateCategory.
	templateRepository := self templateRepository: templateCategory.
   templateRepository templatesAndGroups 
		do: [ :aTemplate | self outStream nextPutAll: aTemplate asString. self outStream newLine. ]
]

{ #category : #'command execution' }
PhLTemplateListCliCommand >> templateCategory [
  ^ (arguments at: #templateCategory) value: self
]

{ #category : #'command execution' }
PhLTemplateListCliCommand >> templateRepository: aTemplateCategoryName [
	| listTemplatesCategories |
	listTemplatesCategories := PhLTemplateGroupRepository
		default roots.
	listTemplatesCategories := listTemplatesCategories
		detect: [ :aGroup | aGroup name = aTemplateCategoryName ].
	^ listTemplatesCategories
]
