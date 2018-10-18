"
Removes the selected template
"
Class {
	#name : #PhLRemoveTemplateCommand,
	#superclass : #PhLTemplateCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLRemoveTemplateCommand class >> group [
	^ 2
]

{ #category : #accessing }
PhLRemoveTemplateCommand class >> icon [
	^ self iconNamed: #smallDelete
]

{ #category : #accessing }
PhLRemoveTemplateCommand class >> title [
	^ 'Remove template'
]

{ #category : #action }
PhLRemoveTemplateCommand >> execute [
	| templates templateNames confirmMessage answer |
	templates := self model selectedTemplates.
	templateNames := templates collect: #name.
	confirmMessage := 'Are you sure you want to delete ' , (templateNames joinUsing: ', ' last: ' and ').
	answer := self model newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer
		ifTrue: [ self model templateRepository deleteTemplates: templates ]
]

{ #category : #testing }
PhLRemoveTemplateCommand >> isApplicable [
	^ super isApplicable and: [ self model hasSingleLocalTemplateSelected ]
]
