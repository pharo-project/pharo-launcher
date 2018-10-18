Class {
	#name : #PhLImagePresenter,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'workingModel',
		'nameLabel',
		'nameTextInput',
		'vmLabel',
		'vmInput',
		'templateLabel',
		'templateInput',
		'lastModificationLabel',
		'lastModificationInput',
		'tagsLabel',
		'tagsInput',
		'commentLabel',
		'commentInput',
		'locationLabel',
		'locationInput'
	],
	#category : 'PharoLauncher-IceTray'
}

{ #category : #specs }
PhLImagePresenter class >> defaultSpec [

	<spec: #default>

	| fontWidth labelsWidth rowHeight checkboxWidth |
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	labelsWidth := fontWidth * 8.
	rowHeight := self inputTextHeight.
	checkboxWidth := fontWidth * 2.
	
	^ SpecLayout composed 
	newRow: [ :mainRow |
		mainRow newColumn: [ :col | 

			col newRow: [ : row | 
				row add: #nameLabel right: labelsWidth.
				row add: #nameTextInput ]
			height: rowHeight.
		
			col newRow: [ :row | 
				row add: #vmLabel right: labelsWidth.
				row add: #vmInput ]
			height: rowHeight.

			col newRow: [ :row | 
				row add: #templateLabel right: labelsWidth.
				row add: #templateInput ]
			height: rowHeight. 
			
			col newRow: [ :row | 
				row add: #locationLabel right: labelsWidth.
				row add: #locationInput ]
			height: rowHeight.

			col newRow: [ :row |  ]. "fill the rest"

			].

		mainRow newColumn: [ :col | 
			
			col newRow: [ :row | 
				row add: #lastModificationLabel right: labelsWidth.
				row add: #lastModificationInput ]
			height: rowHeight.

			col newRow: [ :row | 
				row add: #tagsLabel right: labelsWidth.
				row add: #tagsInput ]
			height: rowHeight.


			col newRow: [ :row | 
				row add: #commentLabel right: labelsWidth.
				row add: #commentInput ]
			height: rowHeight*2.
			
			col newRow: [ :row |  ]. "fill the rest"

	]].


	
]

{ #category : #accessing }
PhLImagePresenter >> commentInput [
	^ commentInput
]

{ #category : #accessing }
PhLImagePresenter >> commentInput: anObject [
	commentInput := anObject
]

{ #category : #accessing }
PhLImagePresenter >> commentLabel [
	^ commentLabel
]

{ #category : #accessing }
PhLImagePresenter >> commentLabel: anObject [
	commentLabel := anObject
]

{ #category : #initialization }
PhLImagePresenter >> fillFormWithWorkingModel [

	self workingModel ifNil: [ ^ self ].

	self nameTextInput text: self workingModel name asString.
	self vmInput text: self workingModel vm asString.	
	self templateInput text: self workingModel template asString.	
	self lastModificationInput text: self workingModel lastModification asString.	
	self tagsInput text: 'no tags support'.
	self commentInput text: 'no comments support'.
	self locationInput text: 'no location support'.

	
]

{ #category : #initialization }
PhLImagePresenter >> initializePresenter [
	
"	self submitButton action: [self submit].	
	self restoreButton action: [self restore].
	
	self number1Input whenTextChanged: [ 
		| receivedText newText |
		receivedText := self number1Input text asString.
		newText := receivedText select: [ :aCharacter | aCharacter isDigit ].
		newText = receivedText ifFalse: [ 
			self number1Input textHolder rawValue: newText.
			self number1Input textHolder valueChanged: newText] ]"
]

{ #category : #initialization }
PhLImagePresenter >> initializeWidgets [

	nameLabel := self newLabel label: 'name:'.
	nameTextInput := self newTextInput autoAccept: true.
	nameTextInput enabled: false.

	vmLabel := self newLabel label: 'VM version:'.
	vmInput := self newTextInput autoAccept: true.
	vmInput enabled: false.
	
	templateLabel := self newLabel label: 'template:'.
	templateInput := self newTextInput autoAccept: true.
	templateInput enabled: false.
	

	lastModificationLabel := self newLabel label: 'modified:'.
	lastModificationInput := self newTextInput autoAccept: true.
	lastModificationInput enabled: false.
	
	tagsLabel := self newLabel label: 'tags:'.
	tagsInput := self newTextInput autoAccept: true.
	tagsInput enabled: false.

	commentLabel := self newLabel label: 'comment:'.
	commentInput := self newTextInput autoAccept: true.
	commentInput enabled: false.

	locationLabel := self newLabel label: 'location:'.
	locationInput := self newTextInput autoAccept: true.
	locationInput enabled: false.
	
	self focusOrder 
		add: nameTextInput;
		add: vmInput;
		add: templateInput;
		add: locationInput;
		add: lastModificationInput;
		add: tagsInput;
		add: commentInput.
		
]

{ #category : #accessing }
PhLImagePresenter >> lastModificationInput [
	^ lastModificationInput
]

{ #category : #accessing }
PhLImagePresenter >> lastModificationInput: anObject [
	lastModificationInput := anObject
]

{ #category : #accessing }
PhLImagePresenter >> lastModificationLabel [
	^ lastModificationLabel
]

{ #category : #accessing }
PhLImagePresenter >> lastModificationLabel: anObject [
	lastModificationLabel := anObject
]

{ #category : #accessing }
PhLImagePresenter >> locationInput [
	^ locationInput
]

{ #category : #accessing }
PhLImagePresenter >> locationInput: anObject [
	locationInput := anObject
]

{ #category : #accessing }
PhLImagePresenter >> locationLabel [
	^ locationLabel
]

{ #category : #accessing }
PhLImagePresenter >> locationLabel: anObject [
	locationLabel := anObject
]

{ #category : #initialization }
PhLImagePresenter >> modelChanged [

	workingModel := self model copy.

	self fillFormWithWorkingModel.

	
]

{ #category : #accessing }
PhLImagePresenter >> nameLabel [
	^ nameLabel
]

{ #category : #accessing }
PhLImagePresenter >> nameLabel: anObject [
	nameLabel := anObject
]

{ #category : #accessing }
PhLImagePresenter >> nameTextInput [
	^ nameTextInput
]

{ #category : #accessing }
PhLImagePresenter >> nameTextInput: anObject [
	nameTextInput := anObject
]

{ #category : #actions }
PhLImagePresenter >> restore [

	self modelChanged

	
]

{ #category : #actions }
PhLImagePresenter >> submit [

	workingModel name: self nameTextInput text.
	workingModel surname: self surnameTextInput text.
	
	self model: workingModel.
	self announcingObject valueChanged.
	
]

{ #category : #accessing }
PhLImagePresenter >> tagsInput [
	^ tagsInput
]

{ #category : #accessing }
PhLImagePresenter >> tagsInput: anObject [
	tagsInput := anObject
]

{ #category : #accessing }
PhLImagePresenter >> tagsLabel [
	^ tagsLabel
]

{ #category : #accessing }
PhLImagePresenter >> tagsLabel: anObject [
	tagsLabel := anObject
]

{ #category : #accessing }
PhLImagePresenter >> templateInput [
	^ templateInput
]

{ #category : #accessing }
PhLImagePresenter >> templateInput: anObject [
	templateInput := anObject
]

{ #category : #accessing }
PhLImagePresenter >> templateLabel [
	^ templateLabel
]

{ #category : #accessing }
PhLImagePresenter >> templateLabel: anObject [
	templateLabel := anObject
]

{ #category : #accessing }
PhLImagePresenter >> vmInput [
	^ vmInput
]

{ #category : #accessing }
PhLImagePresenter >> vmInput: anObject [
	vmInput := anObject
]

{ #category : #accessing }
PhLImagePresenter >> vmLabel [
	^ vmLabel
]

{ #category : #accessing }
PhLImagePresenter >> vmLabel: anObject [
	vmLabel := anObject
]

{ #category : #'accessing - model' }
PhLImagePresenter >> workingModel [
	^ workingModel
]

{ #category : #'accessing - model' }
PhLImagePresenter >> workingModel: anObject [
	workingModel := anObject
]
