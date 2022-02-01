"
Provide an environment that the commands can query and change. The environment is composed of an image repository, a template repository, and a selection (of either images or templates).

Instance Variables
	imageRepository:		the list of available images in the system
	selection:		a current selection of either images or templates
	templateRepository:		the list of templates that can be used to create images.

"
Class {
	#name : #PharoLauncherModel,
	#superclass : #Object,
	#instVars : [
		'selection',
		'imageRepository',
		'templateRepository'
	],
	#classVars : [
		'IsDeployed'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #settings }
PharoLauncherModel class >> deactivateDeployed [
	IsDeployed := false
]

{ #category : #settings }
PharoLauncherModel class >> isDeployed [
	^ IsDeployed ifNil: [ IsDeployed := false ]
]

{ #category : #settings }
PharoLauncherModel class >> makeDeployed [
	IsDeployed := true
]

{ #category : #'instance creation' }
PharoLauncherModel class >> selection: aSelection imageRepository: imageRepository templateRepository: templateRepository [
	^ self new
		setSelection: aSelection imageRepository: imageRepository templateRepository: templateRepository;
		yourself
]

{ #category : #private }
PharoLauncherModel >> ensure: aBoolean [
	aBoolean
		ifFalse: [ PhLCommandError signal ]
]

{ #category : #'testing selection' }
PharoLauncherModel >> hasAtLeastOneImageSelected [
	^ selection anySatisfy: #isImage
]

{ #category : #'testing selection' }
PharoLauncherModel >> hasAtLeastOneTemplateGroupSelected [
	^ selection anySatisfy: #isTemplateGroup
]

{ #category : #testing }
PharoLauncherModel >> hasImageNamed: aString [ 
	^ imageRepository hasImageNamed: aString
]

{ #category : #'testing selection' }
PharoLauncherModel >> hasNoSelection [
	^ selection size = 0
]

{ #category : #'testing selection' }
PharoLauncherModel >> hasSingleImageSelected [
	^ (selection size = 1) and: [ selection anyOne isImage ]
]

{ #category : #'testing selection' }
PharoLauncherModel >> hasSingleLocalTemplateSelected [
	^ (selection size = 1) and: [ selection anyOne isLocalTemplate ]
]

{ #category : #'testing selection' }
PharoLauncherModel >> hasSingleTemplateSelected [
	^ (selection size = 1) and: [ selection anyOne isTemplate ]
]

{ #category : #testing }
PharoLauncherModel >> hasTemplateNamed: aString [ 
	^ templateRepository hasLocalTemplateNamed: aString
]

{ #category : #accessing }
PharoLauncherModel >> imageRepository [
	^ imageRepository
]

{ #category : #announcements }
PharoLauncherModel >> imageRepositoryChanged [
	self imageRepository contentsChanged
]

{ #category : #testing }
PharoLauncherModel >> isNewImageNameValid: aString [ 
	^ aString isEmptyOrNil not and: [ (self hasImageNamed: aString) not ]
]

{ #category : #testing }
PharoLauncherModel >> isNewLocalTemplateNameValid: aString [ 
	^ aString isEmptyOrNil not and: [ (self hasTemplateNamed: aString) not ]
]

{ #category : #action }
PharoLauncherModel >> makeUniqueImageName [
	self shouldBeImplemented.
]

{ #category : #accessing }
PharoLauncherModel >> makeUniqueImageName: aString [
	^ imageRepository makeUniqueImageName: aString
]

{ #category : #accessing }
PharoLauncherModel >> makeUniqueTemplateName: aString [
	^ templateRepository makeUniqueTemplateName: aString
]

{ #category : #'user interaction' }
PharoLauncherModel >> newConfirmation [
	^ PhLUIConfirmation new
]

{ #category : #'user interaction' }
PharoLauncherModel >> newInformation [
	^ PhLUIInformation new
]

{ #category : #'user interaction' }
PharoLauncherModel >> newRequest [
	^ PhLUIRequest new
]

{ #category : #'user interaction' }
PharoLauncherModel >> requestNewImageName: aString [

	self halt. "should not be used"
	^ self newRequest
		title: 'Image name?';
		initialAnswer: aString;
		validateAnswer: [ :answer | (self hasImageNamed: answer) not ];
		request
]

{ #category : #'user interaction' }
PharoLauncherModel >> requestNewTemplateName: aString [ 

	self halt. "should not be used"
	^ self newRequest
		title: 'Template name?';
		initialAnswer: (self makeUniqueTemplateName: aString);
		validateAnswer: [ :answer | 
			(self hasTemplateNamed: answer) 
				ifTrue: [ UIManager default confirm: 'Do you want to override exisiting template?' ]
				ifFalse: [ true ] ];
		request
]

{ #category : #selection }
PharoLauncherModel >> selectedImages [
	^ selection select: #isImage
]

{ #category : #selection }
PharoLauncherModel >> selectedTemplateGroups [
	^ selection select: #isTemplateGroup
]

{ #category : #selection }
PharoLauncherModel >> selectedTemplates [
	^ selection select: #isTemplate
]

{ #category : #initialization }
PharoLauncherModel >> setSelection: aSelection imageRepository: anImageRepository templateRepository: aTemplateRepository [
	selection := aSelection. 
	imageRepository := anImageRepository.
	templateRepository := aTemplateRepository.
]

{ #category : #selection }
PharoLauncherModel >> singleImage [
	self
		ensure: self hasSingleImageSelected.
	^ selection anyOne
]

{ #category : #selection }
PharoLauncherModel >> singleImageName [
	self
		ensure: self hasSingleImageSelected.
		
	^ selection pathNames anyOne
]

{ #category : #selection }
PharoLauncherModel >> singleTemplate [
	self
		ensure: self hasSingleTemplateSelected.
	^ selection anyOne
]

{ #category : #accessing }
PharoLauncherModel >> templateRepository [
	^ templateRepository
]

{ #category : #announcements }
PharoLauncherModel >> templateRepositoryChanged [
	self templateRepository contentsChanged
]

{ #category : #copying }
PharoLauncherModel >> withNewSelection: aSelection [
	^ self copy
		setSelection: aSelection imageRepository: imageRepository templateRepository: templateRepository;
		yourself
]
