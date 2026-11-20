"
I check the patch of RubAbstractTextArea (see PhLPatchRubricTextAreaThemeChanged).
"
Class {
	#name : 'PhLMorphicTextFieldThemeTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'tests' }
PhLMorphicTextFieldThemeTest >> testTextFieldAreaStaysTransparentAfterThemeChange [
	"An opaque area would hide the beginning of the placeholder"

	| field textArea |
	field := SpTextInputFieldPresenter new
		         placeholder: 'Enter image name filter ...';
		         yourself.
	field build.
	textArea := field adapter widget textArea.

	textArea themeChanged.

	self assert: textArea color isTransparent
]
