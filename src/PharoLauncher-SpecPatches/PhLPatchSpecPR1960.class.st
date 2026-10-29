"
PR: https://github.com/pharo-spec/Spec/pull/1960
Spec branch dialog-window-close-box, based on Spec Pharo14:
Morphic dialogs and modals (e.g. the image creation window) have a close box, as on Gtk. Clicking it cancels the dialog, as escape does.

Patched methods (extension protocol *PharoLauncher-SpecPatches-DialogCloseBox):
- SpDialogWindowMorph>>#closeBoxHit
- SpDialogWindowMorph>>#initializeLabelArea

I only document this patch. Remove me, my tag and the patched methods once the fix is in the Spec of the Pharo version used to build Pharo Launcher.
"
Class {
	#name : 'PhLPatchSpecPR1960',
	#superclass : 'Object',
	#category : 'PharoLauncher-SpecPatches-DialogCloseBox',
	#package : 'PharoLauncher-SpecPatches',
	#tag : 'DialogCloseBox'
}
