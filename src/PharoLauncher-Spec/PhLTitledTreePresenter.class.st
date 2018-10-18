"
Models a tree and a title bar with Spec.
"
Class {
	#name : #PhLTitledTreePresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'title',
		'toolbar',
		'tree',
		'contextHolder',
		'repositoryHolder',
		'doubleClickCommandClass',
		'commandClasses'
	],
	#category : 'PharoLauncher-Spec'
}

{ #category : #specs }
PhLTitledTreePresenter class >> specLayout [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :col | 
					col
						newRow: [ :titlebar | 
									titlebar
										add: #title;
										add: #toolbar ]
							height: self toolbarHeight;
						add: #tree ];
		yourself
]

{ #category : #cleanup }
PhLTitledTreePresenter class >> unsubscribeAllRepositories [
	PhLTitledTreePresenter allSubInstancesDo: [:c | c repository ifNotNil: [:r | r unsubscribe: c]]
]

{ #category : #private }
PhLTitledTreePresenter >> buildMenu: menu [
	| currentGroupNumber currentGroup |
	currentGroupNumber := nil.
	currentGroup := MenuGroupPresenter new.
	menu
		title: '  Pharo Launcher';
		icon: (self iconNamed: #pharoIcon);
		addMenuGroup: currentGroup.
	commandClasses
		do: [ :commandClass | 
			| command |
			command := commandClass on: self context.
			command isApplicable
				ifTrue: [ 
					(currentGroupNumber notNil and: [ currentGroupNumber ~= command group ])
						ifTrue: [ 
							currentGroup := MenuGroupPresenter new.
							menu addMenuGroup: currentGroup ].
					currentGroup addMenuItem: command asMenuItem.
					currentGroupNumber := command group ] ]
]

{ #category : #accessing }
PhLTitledTreePresenter >> context [
	 ^ contextHolder value
]

{ #category : #accessing }
PhLTitledTreePresenter >> context: aContext [
	contextHolder value: aContext
]

{ #category : #private }
PhLTitledTreePresenter >> doubleClick [
	"Call me when a user double clicks on an item. I will execute the doubleClickCommandClass."
	self doubleClickCommandClass
		ifNotNil: [ :commandClass | 
			| command |
			command := commandClass on: self context.
			command executeIfApplicable ]
]

{ #category : #accessing }
PhLTitledTreePresenter >> doubleClickCommandClass [
	^ doubleClickCommandClass
]

{ #category : #accessing }
PhLTitledTreePresenter >> doubleClickCommandClass: aCommandClass [
	doubleClickCommandClass := aCommandClass
]

{ #category : #initialization }
PhLTitledTreePresenter >> initialize [
	contextHolder := nil asValueHolder.
	contextHolder whenChangedSend: #updateContext to: self.
	repositoryHolder  := nil asValueHolder.
	commandClasses := Array new.
	super initialize.
]

{ #category : #initialization }
PhLTitledTreePresenter >> initializeWidgets [
	title := self newLabel
		label: '';
		yourself.
	tree := self newTree
		menu: [ :menu | self buildMenu: menu ];
		displayBlock: [ :item | item name ];
		doubleClick: [ self doubleClick ];
		hasChildrenBlock: [ :item | item hasChildren ];
		childrenBlock: [ :item | item children ].
	tree
		whenBuiltDo: [ :t | 
			t widget
				rowColorForEven: self theme backgroundColor lighter
				odd: self theme backgroundColor darker ].
	toolbar := self newCommandToolbar.
	tree whenSelectedItemsChanged: [ self context ifNotNil: [ self updateContext ] ]
]

{ #category : #protocol }
PhLTitledTreePresenter >> makeMultiSelect [
	tree multiSelection: true
]

{ #category : #accessing }
PhLTitledTreePresenter >> menuCommandClasses: aCollection [
	"Call me with a collection of command classes to be shown as buttons in my toolbar"
	commandClasses := aCollection
]

{ #category : #widgets }
PhLTitledTreePresenter >> newCommandToolbar [
	^ self instantiate: PhLCommandToolbar
]

{ #category : #updating }
PhLTitledTreePresenter >> refresh [
	|roots|
	roots := self repositoryRoots. 

	tree roots: (roots collect: [:root | 
		TreeNodePresenter new 
			content: root;
			isExpanded: root isHighlighted ]).
	tree selectedItems: (tree selectedItems intersection: roots)
]

{ #category : #accessing }
PhLTitledTreePresenter >> repository [
	^ repositoryHolder value
]

{ #category : #accessing }
PhLTitledTreePresenter >> repository: aRepository [
	self assert: self repository isNil description: 'Changing the repository is not allowed because we would have to change the context as well'.
	repositoryHolder value: aRepository.
	self repository whenChangedSend: #refresh to: self.
	self whenChangedDo: [ :w | w whenClosedDo: [ self repository unsubscribe: self ] ].
	self refresh
]

{ #category : #private }
PhLTitledTreePresenter >> repositoryRoots [

	^self repository roots
]

{ #category : #accessing }
PhLTitledTreePresenter >> title [
	^ title
]

{ #category : #accessing }
PhLTitledTreePresenter >> title: aString [
	title label: aString
]

{ #category : #accessing }
PhLTitledTreePresenter >> toolbar [
	^ toolbar
]

{ #category : #accessing }
PhLTitledTreePresenter >> toolbarCommandClasses: aCollection [
	"Call me with a collection of command classes to be shown as buttons in my toolbar"
	toolbar commandClasses: aCollection
]

{ #category : #accessing }
PhLTitledTreePresenter >> tree [
	^ tree
]

{ #category : #updating }
PhLTitledTreePresenter >> updateContext [
	"Call me when a new context is passed to the receiver or when the selection of my tree changes"

	| contextWithSelection |
	contextWithSelection := self context withNewSelection: (PhLTreeSelection with: tree selectedItems).
	
	self context: contextWithSelection.
	toolbar context: contextWithSelection.
]
