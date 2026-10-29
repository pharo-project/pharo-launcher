"
PR: https://github.com/pharo-spec/Spec/pull/1959
Spec branch fix-morphic-grid-column-sizing (https://github.com/demarey/Spec), not yet in Pharo 14 Spec:
- Morphic grid: aligned cells get the width of their content, and expandable columns take columnSpacing into account (edit buttons beside drop-lists were clipped).
- Morphic action bar: display the centerPresenter (used by PhLImageDetailPresenter).

Patched methods (extension protocol *PharoLauncher-SpecPatches-GridColumnSizing):
- SpMorphicActionBarAdapter>>#addModelTo:
- SpMorphicGridAdapter>>#basicApplyChildrenAlignmentTo:constraints:
- SpMorphicGridLayoutComputation>>#calculateNotHomogeneousColumnWidths
- SpMorphicGridLayoutComputation>>#heightOf:
- SpMorphicGridLayoutComputation>>#naturalExtentOf:
- SpMorphicGridLayoutComputation>>#widthOf:
- SpToolbarMorph>>#addItemCenter:

I only document this patch. Remove me, my tag and the patched methods once the fix is in the Spec of the Pharo version used to build Pharo Launcher.
"
Class {
	#name : 'PhLPatchSpecPR1959',
	#superclass : 'Object',
	#category : 'PharoLauncher-SpecPatches-GridColumnSizing',
	#package : 'PharoLauncher-SpecPatches',
	#tag : 'GridColumnSizing'
}
