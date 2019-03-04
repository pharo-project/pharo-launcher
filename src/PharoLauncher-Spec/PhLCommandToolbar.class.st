"
I'm responsible for displaying a toolbar from a list of commands (instances of PhLCommand). For each command, I create a dedicated button.

Each time the context changes (i.e., the user selects something different), please send me the message #context: with the new context as parameter. I will take care of updating each of my buttons.
"
Class {
	#name : #PhLCommandToolbar,
	#superclass : #DynamicComposablePresenter,
	#instVars : [
		'contextHolder',
		'commandClassesHolder'
	],
	#category : 'PharoLauncher-Spec'
}

{ #category : #specs }
PhLCommandToolbar class >> specLayout [
	<spec: #default>
	^ SpecLayout composed
]

{ #category : #initialization }
PhLCommandToolbar >> buildButtonWidgetsSpec [
	"Return a collection where odd elements are ids and even elements are the class to instantiate (here PhLCommandButton). I return a collection that is suited to pass to #instantiateModels:."
	^ self commandClasses
		inject: OrderedCollection new
		into: [ :specs :commandClass | 
			specs
				add: commandClass specId;
				add: #PhLCommandButton;
				yourself ]
]

{ #category : #private }
PhLCommandToolbar >> buttonsDo: aBlock [
	"Iterate over all my buttons. aBlock is a one or two argument block. The first argument is the button itself, instance of PhLCommandButton. The second argument (optional) is the related command class."

	self commandClasses do: [ :commandClass | aBlock cull: (self widgets at: commandClass specId) cull: commandClass ]
]

{ #category : #accessing }
PhLCommandToolbar >> commandClasses [
	^ commandClassesHolder value
]

{ #category : #accessing }
PhLCommandToolbar >> commandClasses: aCollection [
	"Each command class in the collection will be represented by a dedicated button in the toolbar"

	self
		assert: aCollection size = (aCollection collect: #specId) asSet size
		description: 'You can''t add 2 commands with the same #specId on the same toolbar'.
	commandClassesHolder value: aCollection
]

{ #category : #accessing }
PhLCommandToolbar >> context [
	^ contextHolder value

]

{ #category : #accessing }
PhLCommandToolbar >> context: aContext [
	contextHolder value: aContext.

]

{ #category : #private }
PhLCommandToolbar >> dynamicLayout [
	"Create a spec layout with 1 row, and as many columns as there are command classes"

	^ SpecLayout composed
		newRow: [ :r | 
			r newColumn: [ :col |  ].
			self commandClasses do: [ :commandClass | r add: commandClass specId width: self class toolbarHeight ] ]
]

{ #category : #initialization }
PhLCommandToolbar >> initialize [
	super initialize.
	contextHolder := nil asValueHolder.
	contextHolder whenChangedSend: #updateContext to: self.
	commandClassesHolder := #() asValueHolder.
	commandClassesHolder whenChangedSend: #updateCommandClasses to: self.
]

{ #category : #initialization }
PhLCommandToolbar >> setFocusOrder [
	"I have no idea what this #focusOrder is about, but it looks important :-)"
	self focusOrder removeAll.
	self buttonsDo: [ :button | self focusOrder add: button ].
]

{ #category : #updating }
PhLCommandToolbar >> updateCommandClasses [
	"We just got new command classes to display. We have to recreate all the buttons"

	self widgets removeAll.
	self instantiatePresenters: self buildButtonWidgetsSpec.
	self
		buttonsDo: [ :button :commandClass | button setCommandClass: commandClass ].
	self setFocusOrder.
	self needRebuild: false.
	self buildWithSpecLayout: self dynamicLayout
]

{ #category : #updating }
PhLCommandToolbar >> updateContext [
	"The context just changed, update all the buttons"

	self context notNil
		ifTrue: [ self buttonsDo: [ :button | button context: self context ] ]
]
