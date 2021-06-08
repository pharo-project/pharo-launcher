"
Abstract superclass of the template and image repositories. User interfaces can use my interface to be notified when my instances change.
"
Class {
	#name : #PhLRepository,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'wantNotification'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #announcements }
PhLRepository >> contentsChanged [
	"Called me to announce that I changed"

	wantNotification
		ifTrue: [ announcer announce: ValueChanged new ]
]

{ #category : #private }
PhLRepository >> dontNotifyDuring: aBlock [
	| wantNotificationBackup |
	[ 
	wantNotificationBackup := wantNotification.
	wantNotification := false.
	aBlock value ]
		ensure: [ wantNotification := wantNotificationBackup ]
]

{ #category : #visiting }
PhLRepository >> extractOn: aVisitor [

	self subclassResponsibility
]

{ #category : #initialization }
PhLRepository >> initialize [
	super initialize.
	announcer := Announcer new.
	wantNotification := true.
]

{ #category : #action }
PhLRepository >> makeUniqueName: baseName among: existingNames [
	"Provide a reasonable default name using the next incremental count for items with similar basenames"

	"See #testMakeUniqueImageName for samples"

	| similarbaseImageNames existingUniquifiers nextUniquifier separator |
	separator := '-'.
	similarbaseImageNames := existingNames select: [ :imageName | imageName beginsWith: baseName ].
	existingUniquifiers := similarbaseImageNames
		collect: [ :imageName | 
			| suffix |
			suffix := imageName allButFirst: baseName size.
			(suffix beginsWith: separator)
				ifTrue: [ (suffix allButFirst: separator size) initialIntegerOrNil ]
				ifFalse: 0 ]
		thenSelect: #notNil.
	existingUniquifiers ifEmpty: [ ^ baseName ].
	nextUniquifier := existingUniquifiers max + 1.
	^ baseName , separator , (nextUniquifier printPaddedWith: $0 to: 2)
]

{ #category : #accessing }
PhLRepository >> roots [
	^ self subclassResponsibility
]

{ #category : #announcements }
PhLRepository >> unsubscribe: aReceiver [
	announcer unsubscribe: aReceiver
]

{ #category : #announcements }
PhLRepository >> whenChangedSend: aSelector to: aReceiver [
	announcer when: ValueChanged send: aSelector to: aReceiver
]
