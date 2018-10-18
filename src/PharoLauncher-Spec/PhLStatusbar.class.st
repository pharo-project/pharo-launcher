"
Models a statusbar with Spec. A statusbar is a small horizontal bar with some text (the content) at the very bottom of a window.
"
Class {
	#name : #PhLStatusbar,
	#superclass : #ComposablePresenter,
	#instVars : [
		'labelModel',
		'toolbar',
		'contextHolder'
	],
	#category : 'PharoLauncher-Spec'
}

{ #category : #specs }
PhLStatusbar class >> specLayout [
	"Need to specify a row layout to account for the toolbar which wants to nest another one inside"

	<spec: #default>
	^ SpecLayout composed
		newRow: [ :r | 
			r
				newColumn: [ :col | col add: #labelModel ];
				newColumn: [ :col | col add: #toolbar ] width: 120];
		yourself
]

{ #category : #accessing }
PhLStatusbar >> commandClasses: aCollection [
	self toolbar commandClasses: aCollection
]

{ #category : #protocol }
PhLStatusbar >> content: aContent [
	labelModel label: aContent
]

{ #category : #accessing }
PhLStatusbar >> context [
	 ^ contextHolder value
]

{ #category : #accessing }
PhLStatusbar >> context: aContext [
	contextHolder value: aContext
]

{ #category : #initialization }
PhLStatusbar >> initialize [
	super initialize.
	contextHolder := nil asValueHolder.
	contextHolder whenChangedSend: #updateContext to: self.
]

{ #category : #initialization }
PhLStatusbar >> initializeWidgets [
	labelModel := self newLabel.
	toolbar := self newCommandToolbar.
]

{ #category : #accessing }
PhLStatusbar >> labelModel [
	^ labelModel
]

{ #category : #widgets }
PhLStatusbar >> newCommandToolbar [
	^ self instantiate: PhLCommandToolbar
]

{ #category : #accessing }
PhLStatusbar >> toolbar [
	^ toolbar
]

{ #category : #updating }
PhLStatusbar >> updateContext [
	"Call me when a new context is passed to the receiver"
	toolbar context: self context
]
