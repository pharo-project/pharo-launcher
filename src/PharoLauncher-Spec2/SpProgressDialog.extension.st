Extension { #name : #SpProgressDialog }

{ #category : #'*PharoLauncher-Spec2' }
SpProgressDialog >> informUserDuring: aBlock [
	
	openAction := aBlock.
	aBlock value: DummySystemProgressItem new.
	"self openModalWithSpec.
	parentWindow ifNotNil: [
		parentWindow takeKeyboardFocus ]"
]
