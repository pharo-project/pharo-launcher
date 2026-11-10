"
No Spec PR yet.
The default style sheet gives no geometry to `.progressBar:label`: the label of a progress bar inherits the height of `.application` (25), the height of the whole progress bar widget. Each time the style is applied (e.g. when the window opens), the label takes all the room and the bar is laid out below it, outside of the widget: the bar is not visible until the label contents change.
Visible with an indeterminate progress bar, whose label never changes.

Patched methods (extension protocol *PharoLauncher-SpecPatches-ProgressBarLabelHeight):
- SpMorphicProgressBarAdapter>>#applyStyle:

I only document this patch. Remove me, my tag and the patched methods once the fix is in the Spec of the Pharo version used to build Pharo Launcher.
"
Class {
	#name : 'PhLSpecPatchProgressBarLabelHeight',
	#superclass : 'Object',
	#category : 'PharoLauncher-SpecPatches-ProgressBarLabelHeight',
	#package : 'PharoLauncher-SpecPatches',
	#tag : 'ProgressBarLabelHeight'
}
