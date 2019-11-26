"
Rename the selected template
"
Class {
	#name : #PhLRenameTemplateCommand,
	#superclass : #PhLTemplateCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLRenameTemplateCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #workspace;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #testing }
PhLRenameTemplateCommand >> canBeExecuted [
	^ self templatesPresenter hasLocalTemplateSelected
]

{ #category : #executing }
PhLRenameTemplateCommand >> execute [ 
	| name template |
	template := self templatesPresenter singleTemplate.
	name := self newTemplateName.
	
	self templatesPresenter templateRepository rename: template to: name.
	self templatesPresenter refresh. 
]

{ #category : #initialization }
PhLRenameTemplateCommand >> initialize [
	super initialize.
	self
		name: 'Rename template';
		description: 'Rename the selected template from the local cache'
]

{ #category : #'instance creation' }
PhLRenameTemplateCommand >> newTemplateName [
	^ self newTemplateName: self templatesPresenter singleTemplate name
]

{ #category : #'instance creation' }
PhLRenameTemplateCommand >> newTemplateName: aString [ 
	^ self templatesPresenter newRequest 
		title: 'New name for the template?';
		initialAnswer: aString;
		validateAnswer: [ :answer | (self templatesPresenter templateRepository hasLocalTemplateNamed: answer) not ];
		request
]
