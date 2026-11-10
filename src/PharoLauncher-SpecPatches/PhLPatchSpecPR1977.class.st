"
PR: https://github.com/pharo-spec/Spec/pull/1977
Spec branch fix-morphic-link-help (https://github.com/demarey/Spec), based on Spec Pharo14:
SpMorphicLinkAdapter set the balloon help of its morph only when building it, from the presenter help: a help changed later (e.g. the image location in PhLImageDetailPresenter) was ignored, and an empty help displayed an empty balloon.

Patched methods (extension protocol *PharoLauncher-SpecPatches-LinkHelp):
- SpMorphicLinkAdapter>>#buildWidget
- SpMorphicLinkAdapter>>#getHelpText

I only document this patch. Remove me, my tag and the patched methods once the fix is in the Spec of the Pharo version used to build Pharo Launcher.
"
Class {
	#name : 'PhLPatchSpecPR1977',
	#superclass : 'Object',
	#category : 'PharoLauncher-SpecPatches-LinkHelp',
	#package : 'PharoLauncher-SpecPatches',
	#tag : 'LinkHelp'
}
