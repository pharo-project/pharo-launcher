"
A titled tree with a filter
"
Class {
	#name : #PhLSearchableTitledTreePresenter,
	#superclass : #PhLTitledTreePresenter,
	#instVars : [
		'filterPattern',
		'regexMatcher',
		'selectionChangedBlock',
		'search'
	],
	#classVars : [
		'DateDisplayStrategy',
		'DisplayColorsForDates'
	],
	#category : 'PharoLauncher-Spec'
}

{ #category : #accessing }
PhLSearchableTitledTreePresenter class >> dateDisplayStrategy [
	^ DateDisplayStrategy ifNil: [ DateDisplayStrategy := PhLTimeUntilNowStrategy ]
]

{ #category : #accessing }
PhLSearchableTitledTreePresenter class >> dateDisplayStrategy: anObject [
	DateDisplayStrategy := anObject
]

{ #category : #accessing }
PhLSearchableTitledTreePresenter class >> displayColorsForDates [
	^ DisplayColorsForDates ifNil: [ DisplayColorsForDates := true ]
]

{ #category : #accessing }
PhLSearchableTitledTreePresenter class >> displayColorsForDates: aBoolean [
	DisplayColorsForDates := aBoolean
]

{ #category : #settings }
PhLSearchableTitledTreePresenter class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	
	(aBuilder pickOne: #dateDisplayStrategy)
		label: 'Date format' translated;
		target: self;
		parent: ##appearance;
		order: 32;
		domainValues: PhLAbstractDateDisplayStrategy allStrategiesWithNames;
		description: 'Customize the format of the dates in the PharoLauncher UI.'.
		
	(aBuilder setting: #displayColorsForDates)
		label: 'Display dates with colors' translated;
		parent: #appearance;
		target: self;
		order: 34;
		description: 'When this option is enable it will display the date in colors. The color depend on the senority of the date.'
]

{ #category : #specs }
PhLSearchableTitledTreePresenter class >> specLayout [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :col | 
					col
						newRow: [ :titlebar | 
									titlebar
										add: #title;
										add: #toolbar ]
							height: self toolbarHeight;
						newRow:  #searchField  	
						height: self toolbarHeight;	
						add: #tree ];
		yourself
]

{ #category : #accessing }
PhLSearchableTitledTreePresenter >> dateDisplayStrategy [
	^ self class dateDisplayStrategy
]

{ #category : #accessing }
PhLSearchableTitledTreePresenter >> displayColorsForDate [
	^ self class displayColorsForDates
]

{ #category : #'private - filtering' }
PhLSearchableTitledTreePresenter >> filterPattern: aRegexMatcher [ 
	regexMatcher := aRegexMatcher 
	 
]

{ #category : #initialization }
PhLSearchableTitledTreePresenter >> initializeWidgets [
	| detailsColumn imageColumn archColumn timestampColumn |
	
	super initializeWidgets.
	
	(timestampColumn := TreeColumnPresenter new) 
		headerLabel: 'Last Modified';
		headerAction: [ self sortContentByDateModfied ];
		displayBlock: [ :item | self printDateOfLastModificationOf: item ];
		initialWidth: 125.
		
	(archColumn := TreeColumnPresenter new) 
		headerLabel: 'Arch';
		headerAction: [ self sortContentByArch ];
		displayBlock: [ :item | item content architecture ];
		initialWidth: 40.
		
	(detailsColumn := TreeColumnPresenter new) 
		headerLabel: 'Template';
		headerAction: [ self sortContentByTemplate ];
		displayBlock: [ :item | item content originTemplateName ].
		
	imageColumn := tree columns first.
	imageColumn 
		headerLabel: 'Name';
		headerAction: [ self sortContentByName ];
		initialWidth: 350.

	tree columns: (tree columns, { timestampColumn . archColumn . detailsColumn }).
	
	tree
		bindKeyCombination: Character cr asKeyCombination
		toAction: [ self doubleClick ].
	self searchField
		bindKeyCombination: Character tab asKeyCombination
		toAction: [ self selectFirstItem ]
]

{ #category : #initialization }
PhLSearchableTitledTreePresenter >> newSearchField [
	
	^ SearchMorph new
		model: self;
		setIndexSelector: #searchAccept:; 
		updateSelector: #searchAccept:;
		acceptSelector: #searchAccept:;
		searchList: OrderedCollection new;
		ghostText: 'Filter...';
		asSpecAdapter
]

{ #category : #printing }
PhLSearchableTitledTreePresenter >> printDateOfLastModificationOf: anItem [
	| text date delta |
	date := anItem content file modificationTime.
	text := self dateDisplayStrategy displayStringOf: date.
	self displayColorsForDate
		ifTrue: [ text makeAllColor: (Color fromHexString: '90A4AE').
			delta := DateAndTime now - date.
			delta days < 31
				ifTrue: [ text makeAllColor: (Color fromHexString: 'FF9800') ].
			delta days < 8
				ifTrue: [ text makeAllColor: (Color fromHexString: '4CAF50') ].
			delta days < 3
				ifTrue: [ text makeAllColor: (Color fromHexString: '009688') ] ].
	^ text asMorph lock
]

{ #category : #'private - accessing' }
PhLSearchableTitledTreePresenter >> repositoryRoots [

	^regexMatcher isNil ifTrue: [ self repository roots ]
					    ifFalse: [ self repository roots select: [ :each| regexMatcher search: each name asString ]] 
]

{ #category : #'private - filtering' }
PhLSearchableTitledTreePresenter >> searchAccept: aString [

	 aString isEmptyOrNil
		ifTrue: [ self filterPattern: nil ]
		ifFalse: [ self filterPattern: 
					([ aString asRegexIgnoringCase ] on: RegexSyntaxError do: [ aString ])].
	self refresh			
 
]

{ #category : #'private - accessing' }
PhLSearchableTitledTreePresenter >> searchField [
	
	^ search ifNil: [ search := self newSearchField ]
]

{ #category : #'private - filtering' }
PhLSearchableTitledTreePresenter >> selectFirstItem [
	| first |
	
	first := tree roots ifEmpty: [ ^self ] ifNotEmpty: [:items | items first ].
	"Not sure how to select first?"
	tree
		takeKeyboardFocus;
		selectAll
]

{ #category : #'private - filtering' }
PhLSearchableTitledTreePresenter >> sortContentByArch [ 

	self sortTreeWith: [:image1 :image2 | image1 architecture > image2 architecture ]
	
]

{ #category : #'private - filtering' }
PhLSearchableTitledTreePresenter >> sortContentByDateModfied [ 

	self sortTreeWith: [:item1 :item2 |
		item1 file modificationTime > item2 file modificationTime]
	
]

{ #category : #'private - filtering' }
PhLSearchableTitledTreePresenter >> sortContentByName [

	self sortTreeWith: [:item1 :item2 |
		item1 printString < item2 printString]
	
]

{ #category : #'private - filtering' }
PhLSearchableTitledTreePresenter >> sortContentByTemplate [ 

	self sortTreeWith: [:item1 :item2 | item1 originTemplateName > item2 originTemplateName ]
	
]

{ #category : #'private - filtering' }
PhLSearchableTitledTreePresenter >> sortTreeWith: sortBlock [
	"Sort the model tree with a 2 parameter sortBlock"
	| roots |
	roots := self repositoryRoots asSortedCollection: sortBlock.

	tree roots: (roots collect: [:root | 
		TreeNodePresenter new 
			content: root;
			isExpanded: root isHighlighted ]).
	tree selectedItems: (tree selectedItems intersection: roots)
	
]

{ #category : #initialization }
PhLSearchableTitledTreePresenter >> updateContext [
	"Call me when a new context is passed to the receiver or when the selection of my tree changes"

	super updateContext.
	
	selectionChangedBlock
		ifNotNil: [ selectionChangedBlock cull: tree selectedItems ]
]

{ #category : #initialization }
PhLSearchableTitledTreePresenter >> whenSelectionChanged: aBlock [

	selectionChangedBlock := aBlock
]
