"
Removes the selected template
"
Class {
	#name : #PhLRemoveTemplateCommand2,
	#superclass : #PhLTemplateCommand2,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLRemoveTemplateCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallDelete;
		shortcutKey: $x meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #testing }
PhLRemoveTemplateCommand2 >> canBeExecuted [
	^ self templatesPresenter hasLocalTemplatesSelected
]

{ #category : #executing }
PhLRemoveTemplateCommand2 >> execute [ 
	| templates templateNames confirmMessage answer |
	templates := self templatesPresenter selectedTemplates.
	templates ifEmpty: [ ^ self ].
	
	templateNames := templates collect: #name.
	confirmMessage := 'Are you sure you want to delete ' , (templateNames joinUsing: ', ' last: ' and ').
	answer := self templatesPresenter newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer ifFalse: [ ^ self "abort" ].
		
	self templatesPresenter templateRepository deleteTemplates: templates.
	self templatesPresenter refresh. 
]

{ #category : #initialization }
PhLRemoveTemplateCommand2 >> initialize [
	super initialize.
	self
		name: 'Remove template';
		description: 'Remove the selected template from the local cache'
]
