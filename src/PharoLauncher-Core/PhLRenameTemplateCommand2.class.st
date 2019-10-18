"
Rename the selected template
"
Class {
	#name : #PhLRenameTemplateCommand2,
	#superclass : #PhLTemplateCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLRenameTemplateCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #workspace;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #testing }
PhLRenameTemplateCommand2 >> canBeExecuted [
	^ self templatesPresenter hasLocalTemplateSelected
]

{ #category : #executing }
PhLRenameTemplateCommand2 >> execute [ 
	| name template |
	template := self templatesPresenter singleTemplate.
	name := self newTemplateName.
	
	self templatesPresenter templateRepository rename: template to: name.
	self templatesPresenter refresh. 
]

{ #category : #initialization }
PhLRenameTemplateCommand2 >> initialize [
	super initialize.
	self
		name: 'Rename template';
		description: 'Rename the selected template from the local cache'
]

{ #category : #'instance creation' }
PhLRenameTemplateCommand2 >> newTemplateName [
	^ self newTemplateName: self templatesPresenter singleTemplate name
]

{ #category : #'instance creation' }
PhLRenameTemplateCommand2 >> newTemplateName: aString [ 
	^ self templatesPresenter newRequest 
		title: 'New name for the template?';
		initialAnswer: aString;
		validateAnswer: [ :answer | (self templatesPresenter templateRepository hasLocalTemplateNamed: answer) not ];
		request
]
