"
I represent a button that is bound to a particular command (instance of PhLCommand). When the context changes, I update my representation.
"
Class {
	#name : #PhLCommandButton,
	#superclass : #ButtonPresenter,
	#instVars : [
		'commandClass',
		'contextHolder',
		'command'
	],
	#category : 'PharoLauncher-Spec'
}

{ #category : #accessing }
PhLCommandButton >> context [
	^ contextHolder value
]

{ #category : #accessing }
PhLCommandButton >> context: aContext [
	contextHolder value: aContext
]

{ #category : #initialization }
PhLCommandButton >> initialize [
	super initialize.
	contextHolder := nil asValueHolder.
	contextHolder whenChangedSend: #update to: self
]

{ #category : #updating }
PhLCommandButton >> performAction [
	command executeIfApplicable.
	super performAction.
	self update.
]

{ #category : #initialize }
PhLCommandButton >> setCommandClass: aCommandClass [
	commandClass := aCommandClass.
	self
		help: commandClass title;
		icon: commandClass icon;
		state: false
]

{ #category : #updating }
PhLCommandButton >> update [
	self context
		ifNotNil: [ :context | 
			command := commandClass on: context.
			self enabled: command isApplicable ]
]
