"
Removes the selected template
"
Class {
	#name : #PhLRemoveTemplateCommand,
	#superclass : #PhLTemplateCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLRemoveTemplateCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallDelete;
		shortcutKey: $x meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #testing }
PhLRemoveTemplateCommand >> canBeExecuted [
	^ self templatesPresenter hasLocalTemplatesSelected
]

{ #category : #executing }
PhLRemoveTemplateCommand >> execute [ 
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
PhLRemoveTemplateCommand >> initialize [
	super initialize.
	self
		name: 'Remove template';
		description: 'Remove the selected template from the local cache'
]
