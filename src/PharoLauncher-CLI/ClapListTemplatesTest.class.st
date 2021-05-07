Class {
	#name : #ClapListTemplatesTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-CLI'
}

{ #category : #tests }
ClapListTemplatesTest >> testExecuteCommandWhenThereIsMoreTemplatePrintsTheListOfTemplates [
	| command output repo |
	command := ClapListTemplates new.
   repo := PhLMockTemplatesRepository new.
   repo localTemplateNames: OrderedCollection new.
   repo localTemplateNames add: 'Pharoblabla'. 
   repo localTemplateNames add: 'Pharo2'.
   repo localTemplateNames add: 'Pharo3'.
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListTemplates ].
   self assert: output equals: 'Pharoblabla
Pharo2
Pharo3
'.
]

{ #category : #tests }
ClapListTemplatesTest >> testExecuteCommandWhenThereIsOneTemplatePrintsTheListOfTemplates [
	| command output repo |
	command := ClapListTemplates new.
   repo := PhLMockTemplatesRepository new.
   repo localTemplateNames: OrderedCollection new.
   repo localTemplateNames add: 'Pharoblabla'. 
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListTemplates ].
   self assert: output equals: 'Pharoblabla
'.
]
