"
Fixed in Pharo 15 Spec: https://github.com/pharo-spec/Spec/commit/e8f1e7107a97cf43f445683dbd1f03870590e878
Not in Pharo 14 Spec.
SpFontStyle made shared LogicalFont instances bold or italic, so a bold style (e.g. list headers) turned the default font bold everywhere.

Patched methods (extension protocol *PharoLauncher-SpecPatches-FontStyleSharedFont):
- SpFontStyle>>#calculateDefinedFont

I only document this patch. Remove me, my tag and the patched methods once the fix is in the Spec of the Pharo version used to build Pharo Launcher.
"
Class {
	#name : 'PhLSpecPatchFontStyleSharedFont',
	#superclass : 'Object',
	#category : 'PharoLauncher-SpecPatches-FontStyleSharedFont',
	#package : 'PharoLauncher-SpecPatches',
	#tag : 'FontStyleSharedFont'
}
