Extension { #name : #ScrollPane }

{ #category : #'*PharoLauncher-100Compatibility' }
ScrollPane >> mouseDown: evt [
	"Dirty fix for DropList events triggereed twice: see https://github.com/pharo-spec/Spec/issues/1259"
	"Should be removed once the bug is solved in Spec / Morphic"
]
