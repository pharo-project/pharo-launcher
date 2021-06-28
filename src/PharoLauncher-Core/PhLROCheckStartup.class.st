"
Startup action used to check if the image can write in the working directory.
Currently needed for Epicea, logs, etc.
"
Class {
	#name : #PhLROCheckStartup,
	#superclass : #Object,
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #initialization }
PhLROCheckStartup class >> initialize [
	"Must be run before any write acess to the file system.
	UI should already be usable!"
	"SessionManager default 
		register: (ClassSessionHandler forClassNamed: self name)
		inCategory: SessionManager default toolsCategory
		atPriority: 1"
]

{ #category : #'system startup' }
PhLROCheckStartup class >> startUp [
	
	self verifyCanWrite
]

{ #category : #'system startup' }
PhLROCheckStartup class >> verifyCanWrite [

	[ (FileLocator workingDirectory / 'phl-canwrite') asFileReference  
			ensureDelete; 
			createDirectory;
			ensureDelete. ]
	on: Error
	do: [ :error |
		PharoLauncherApplication default newInform 
			title: 'Cannot run PharoLauncher!';
			label: 'PharoLauncher cannot be run from a read-only filesystem. 
Please move it to a place where you have write permissions!';
			openModalWithSpec.
		Smalltalk exitFailure ]
]
