"
PR: https://github.com/pharo-spec/Spec/pull/1976
Spec branch fix-inform-dialog-extent (https://github.com/demarey/Spec), based on Spec Pharo14:
SpInformDialog only defines the old #defaultExtent (450@120), not #defaultPreferredExtent as SpConfirmDialog and SpRequestDialog do: its preferred extent was the one of any presenter (700@500), too big for a message.

Patched methods (extension protocol *PharoLauncher-SpecPatches-InformDialogExtent):
- SpInformDialog class>>#defaultPreferredExtent

I only document this patch. Remove me, my tag and the patched methods once the fix is in the Spec of the Pharo version used to build Pharo Launcher.
"
Class {
	#name : 'PhLPatchSpecPR1976',
	#superclass : 'Object',
	#category : 'PharoLauncher-SpecPatches-InformDialogExtent',
	#package : 'PharoLauncher-SpecPatches',
	#tag : 'InformDialogExtent'
}
