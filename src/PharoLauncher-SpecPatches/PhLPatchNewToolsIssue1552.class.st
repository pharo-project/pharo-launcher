"
Issue: https://github.com/pharo-spec/NewTools/issues/1552
PR: https://github.com/pharo-spec/NewTools/pull/1566
NewTools Morphic file dialog, not fixed in NewTools Pharo14:
SpMorphicBackend>>#executeOpenFileDialog: sends #answer to the result of StFileDialogPresenter>>#openModal, that answers the selected entries, or nil when the dialog is cancelled. Choosing or cancelling a file to import an image failed.
As the Gtk backend, the patched method answers the chosen file reference, or nil.

Patched methods (extension protocol *PharoLauncher-SpecPatches-NewToolsOpenFileDialog):
- SpMorphicBackend>>#executeOpenFileDialog:

I only document this patch. Remove me, my tag and the patched methods once the fix is in the NewTools of the Pharo version used to build Pharo Launcher.
"
Class {
	#name : 'PhLPatchNewToolsIssue1552',
	#superclass : 'Object',
	#category : 'PharoLauncher-SpecPatches-NewToolsOpenFileDialog',
	#package : 'PharoLauncher-SpecPatches',
	#tag : 'NewToolsOpenFileDialog'
}
