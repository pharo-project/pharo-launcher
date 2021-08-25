"
You can use me to easily package an image.
It includes the shipping of the VM as well as a run script for the current image.
It can also the generation of a run script using pharo-launcher.
"
Class {
	#name : #PhLImagePackageCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'image'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImagePackageCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #package
]

{ #category : #'command line' }
PhLImagePackageCliCommand class >> launcherCmdDescription [
	^ 'Creates a package containing everything neeeded to launch easily the image.'
]

{ #category : #'command line - arguments' }
PhLImagePackageCliCommand class >> launcherCmdFlags [
	^ {(ClapFlag id: #zip)
			description: 'The resulting package is zipped';
			meaning: [ :arg :app | true];
			implicitMeaning: [ :arg :app | false  ].
		(ClapFlag id: #vm)
				description: 'Allows to specify the vm to use to launch the image';
				meaning: [ :arg :app | (arg at: #vmId) word ];
				implicitMeaning: [ :arg :app | 'default' ];
				add: ((ClapPositional id: #vmId)
					description: 'Id of the vm to use';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [ :arg :app | 'default' ]).
			}
]

{ #category : #'command line - arguments' }
PhLImagePackageCliCommand class >> launcherCmdPositionals [

	^ {((ClapPositional id: #existingImageName)
				description: 'Local image name to create the launch script.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'need an image to create the script' . ];
					yourself).
		((ClapPositional id: #location)
				description: 'Local image name to create the launch script.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app |NotFound signal: 'no path to put the package' ];
					yourself).
	}
]

{ #category : #conversion }
PhLImagePackageCliCommand >> convertToZip: imageFolderFileReference [ 
	| zip |
	zip := ZipArchive new.
	zip addTree: imageFolderFileReference relativeTo: (imageFolderFileReference parent) match: [ :e | true ].
	zip writeToFile:  ( self location, '/' ,self image name,'.zip' ) asFileReference
]

{ #category : #copying }
PhLImagePackageCliCommand >> copyFilesOf: anImage at: aDirectory [
	| imageFolder |
	imageFolder := anImage file parent.
	(imageFolder / (anImage name,'.image')) 
		copyTo: (aDirectory , '/' , anImage name , '.image') asFileReference.
	(imageFolder / (anImage name,'.sh')) 
		copyTo: (aDirectory , '/' , anImage name , '.sh') asFileReference.
	(imageFolder / (anImage name,'.changes')) 
		copyTo: (aDirectory , '/' , anImage name , '.changes') asFileReference.
	(PhLVirtualMachineManager vmStore / self vmId)
		copyAllTo: (aDirectory , '/', self vmId) asFileReference
]

{ #category : #creation }
PhLImagePackageCliCommand >> createDirectoryAccordingToPath: aPath [ 
	aPath asFileReference ensureCreateDirectory 
]

{ #category : #'script generation' }
PhLImagePackageCliCommand >> createLaunchScript: anImage [
	anImage launchScriptName
		writeStreamDo: [ :stream | stream nextPutAll: (self launchScriptFor: anImage) ].
	
]

{ #category : #accessing }
PhLImagePackageCliCommand >> defaultVmId [
	^ self image vmManager vmId

]

{ #category : #testing }
PhLImagePackageCliCommand >> directoryAlreadyExists: aDirectory [ 
	^ ((self imageRepository baseDirectory fileSystem
			exists: aDirectory)
			and: [ self imageRepository baseDirectory fileSystem
					isDirectory: aDirectory ])
]

{ #category : #copying }
PhLImagePackageCliCommand >> ensureExecutionPermissionFor: anImage [
	self ensureVmFileIsExecutable: anImage.
	self ensureLaunchScriptIsExecutable: anImage.
]

{ #category : #copying }
PhLImagePackageCliCommand >> ensureLaunchScriptIsExecutable: anImage [
	LibC
		runCommand:
			'find ' , self location , '/"' , anImage name , '" -iname "'
				, anImage name , '.sh" -type f -exec chmod +x {} \;'.
]

{ #category : #copying }
PhLImagePackageCliCommand >> ensureVmFileIsExecutable: anImage [
	LibC
		runCommand:
			'find ' , self location , '/"' , anImage name , '"/' , self vmId
				, ' -type f -exec chmod +x {} \;'.
]

{ #category : #accessing }
PhLImagePackageCliCommand >> executeWithImage: anImage [
	| userNewDirectory |
	self image: anImage.
	userNewDirectory := [ self location , '/' , anImage name ]
		on: NotFound
		do: [ :error | 
			^ self errorStream
				nextPutAll: error messageText;
				lf ].
	self createLaunchScript: anImage.
	(self directoryAlreadyExists: userNewDirectory)
		ifTrue: [ ^ self errorStream
				nextPutAll:
					'a Directory with the image name already exists at that location, please select another location';
				newLine ].
	self createDirectoryAccordingToPath: userNewDirectory.
	self copyFilesOf: anImage at: userNewDirectory.
	self ensureExecutionPermissionFor: anImage .
	self shouldZip
		ifTrue: [ self convertToZip: userNewDirectory asFileReference ]
]

{ #category : #accessing }
PhLImagePackageCliCommand >> image [
	^ image
]

{ #category : #accessing }
PhLImagePackageCliCommand >> image: anImage [
	image := anImage
]

{ #category : #'script generation' }
PhLImagePackageCliCommand >> launchScriptFor: anImage [
	^ self launchScriptTemplate  
        format: (Dictionary 
            with: #IMAGE_NAME -> anImage name
            with: #VM_ID -> self vmId)

]

{ #category : #'script generation' }
PhLImagePackageCliCommand >> launchScriptTemplate [
	^ '#!/usr/bin/env bash
# some magic to find out the real location of this script dealing with symlinks
DIR=`readlink "$0"` || DIR="$0";
ROOT=`dirname "$DIR"`;

# DETECT SYSTEM PROPERTIES ======================================================
TMP_OS=`uname | tr "[:upper:]" "[:lower:]"`
if [[ "\{$TMP_OS}" = *darwin* ]]; then
    OS="mac";
elif [[ "\{$TMP_OS}" = *linux* ]]; then
    OS="linux";
else
    echo "Unsupported OS";
    exit 1;
fi

# RUN THE VM and pass along all arguments as is ================================
if [ "$OS" = "linux" ]; then
    "$ROOT"/{VM_ID}/pharo "$ROOT"/{IMAGE_NAME}.image
elif [ "$OS" = "mac" ]; then 
    "$ROOT"/{VM_ID}/Pharo.app/Contents/MacOS/Pharo "$ROOT"/{IMAGE_NAME}.image 
fi' withUnixLineEndings 
]

{ #category : #accessing }
PhLImagePackageCliCommand >> location [
	^ (arguments at: #location) value: self
]

{ #category : #testing }
PhLImagePackageCliCommand >> shouldZip [
	^ (arguments at: #zip) value: self
]

{ #category : #accessing }
PhLImagePackageCliCommand >> vmId [
	| argAtVmName |
	argAtVmName := (arguments at: #vm) value: self.
	argAtVmName = 'default' ifTrue: [ argAtVmName := self defaultVmId ].
	^ argAtVmName
]
