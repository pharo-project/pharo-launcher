"
Warning raised when we try to launch an image with an intel VM on an ARM architecture (mac Os).
The VM is then translaetd by Rosetta, and the image runs very slowly.
"
Class {
	#name : #PhLTranslatedModeWarning,
	#superclass : #Warning,
	#category : #'PharoLauncher-Core-Exceptions'
}
