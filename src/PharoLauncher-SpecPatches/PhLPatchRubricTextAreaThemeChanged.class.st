"
Issue: not reported yet.
Not fixed in Rubric Pharo14 nor Pharo15:
A text area in a scroll pane is transparent, the scroll pane draws the background (see RubAbstractTextArea>>#scrollPane:). RubAbstractTextArea>>#themeChanged gives it the opaque background color of the theme. The area of a text field is as wide as its text: when the field is empty, the area hides the beginning of the placeholder (e.g. 'er image name filter ...').

Patched methods (extension protocol *PharoLauncher-SpecPatches-RubricTextAreaThemeChanged):
- RubAbstractTextArea>>#themeChanged

I only document this patch. Remove me, my tag and the patched methods once the fix is in the Rubric of the Pharo version used to build Pharo Launcher.
"
Class {
	#name : 'PhLPatchRubricTextAreaThemeChanged',
	#superclass : 'Object',
	#category : 'PharoLauncher-SpecPatches-RubricTextAreaThemeChanged',
	#package : 'PharoLauncher-SpecPatches',
	#tag : 'RubricTextAreaThemeChanged'
}
