"
PR: https://github.com/pharo-spec/Spec/pull/1975
Spec branch fix-paned-fractional-position (https://github.com/demarey/Spec), based on Spec Pharo14:
Morphic paned layout: a fractional slider position (e.g. 750 * 35 percent = 525/2) is answered as an integer. Otherwise each layout set the height of the first morph again, which reset the rows of a table in the pane: clicks on the table were ignored.

Patched methods (extension protocol *PharoLauncher-SpecPatches-PanedFractionalPosition):
- SpMorphicPanedLayout>>#heightPositionIn:
- SpMorphicPanedLayout>>#widthPositionIn:

I only document this patch. Remove me, my tag and the patched methods once the fix is in the Spec of the Pharo version used to build Pharo Launcher.
"
Class {
	#name : 'PhLPatchSpecPR1975',
	#superclass : 'Object',
	#category : 'PharoLauncher-SpecPatches-PanedFractionalPosition',
	#package : 'PharoLauncher-SpecPatches',
	#tag : 'PanedFractionalPosition'
}
