"
I represent Pharo Template list sub-command invoked from cmd line of Pharo Launcher. My responsibility is to list local templates. 

I declare: 
- optional flag for stonOutput

I execute:
- list local images with detailed information about image name, used VM, architecture, local dir, etc.
"
Class {
	#name : #PhLTemplateListCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLTemplateListCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #list launcherModel: aPharoLauncherModel
]

{ #category : #'command execution' }
PhLTemplateListCliCommand >> execute [
   self outputListTemplates.
]

{ #category : #initialization }
PhLTemplateListCliCommand >> outputListTemplates [

	self pharoLauncherModel templateBaseRepository localTemplateNames
		do: [ :aTemplate | self outStream nextPutAll: aTemplate asString. self outStream cr. ]
]
