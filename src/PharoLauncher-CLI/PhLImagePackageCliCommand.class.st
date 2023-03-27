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
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImagePackageCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	aCommandSpec 
		addFlag: #zip
		description: 'Creates the package with image as a ZIP file.'.

	aCommandSpec 
		addFlagWithPositional: #vm
		description: 'Specifies the VM used for launching the image.'

]

{ #category : #'command line - arguments' }
PhLImagePackageCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	(aCommandSpec 
		addPositional: #existingImageName 
		description: 'Local image name, for which is package created.')
	implicitMeaning: [:arg :app | self raiseMissingImageToPackage].
	(aCommandSpec 
		addPositional: #location 
		description: 'Specifies the directory path, where resulting package will be stored.')
	implicitMeaning: [:arg :app | self raiseMissingResultingPackagePath].
]

{ #category : #'command line' }
PhLImagePackageCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #package
]

{ #category : #'command line' }
PhLImagePackageCliCommand class >> launcherCmdDescription [
	^ 'Creates a package containing all necessary artefacts to launch the image.'
]

{ #category : #'error signalling' }
PhLImagePackageCliCommand class >> raiseMissingImageToPackage [

	^ NotFound signal: 'An argument is missing, please specify the image name to pack.'
]

{ #category : #'error signalling' }
PhLImagePackageCliCommand class >> raiseMissingResultingPackagePath [

	^ NotFound signal: 'An argument is missing, please specify the path, where resulting package will be stored.'
]

{ #category : #'command execution' }
PhLImagePackageCliCommand >> basicExecute [ 

	| userNewDirectory |
	self image: self findImage.
	userNewDirectory := self createDirectoryForImageToPack.
	self createLaunchScript.
	self copyImageFilesTo: userNewDirectory.
	self ensureExecutionPermissionForImage.
	self shouldZip
		ifTrue: [ self convertToZip: userNewDirectory ]
]

{ #category : #private }
PhLImagePackageCliCommand >> convertToZip: imageFolderFileReference [ 
	| zip |
	zip := ZipArchive new.
	zip addTree: imageFolderFileReference relativeTo: (imageFolderFileReference parent) match: [ :e | true ].
	zip writeToFile:  ( self location, '/' ,self image name,'.zip' ) asFileReference
]

{ #category : #private }
PhLImagePackageCliCommand >> copyImageFilesTo: targetDirectory [

	| imageFolder anImage|
	anImage := self image.
	imageFolder := anImage file parent.

	"copy image, launch script and changes"
	#('.image' '.sh' '.changes') do: [:artefactExtension | 
		| artefactName |
		artefactName := String streamContents: [:s |  
			s nextPutAll: anImage name; 
			  nextPutAll: artefactExtension].
		(imageFolder / artefactName ) copyTo: (targetDirectory / artefactName) asFileReference.	
	].

	"copy vm directory content to target image directory"
	(PhLVirtualMachineManager vmStore / self vmId)
		copyAllTo: (targetDirectory / self vmId) asFileReference.
]

{ #category : #private }
PhLImagePackageCliCommand >> createDirectoryForImageToPack [
	|aPath| 
	aPath := self location , '/' , self image name.
	(self directoryAlreadyExists: aPath) ifTrue: [self raiseDirectoryAlreadyExists: aPath].
	^ aPath asFileReference ensureCreateDirectory
]

{ #category : #private }
PhLImagePackageCliCommand >> createLaunchScript [

	self image launchScriptName
	writeStreamDo: [ :stream | 
		stream nextPutAll: (self launchScriptFor: self image)
	]
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

{ #category : #private }
PhLImagePackageCliCommand >> ensureExecutionPermissionForImage [
	
	self ensureVmFileIsExecutable: self image.
	self ensureLaunchScriptIsExecutable: self image.
]

{ #category : #private }
PhLImagePackageCliCommand >> ensureLaunchScriptIsExecutable: anImage [
	LibC
		runCommand:
			'find ' , self location , '/"' , anImage name , '" -iname "'
				, anImage name , '.sh" -type f -exec chmod +x {} \;'.
]

{ #category : #private }
PhLImagePackageCliCommand >> ensureVmFileIsExecutable: anImage [
	LibC
		runCommand:
			'find ' , self location , '/"' , anImage name , '"/' , self vmId
				, ' -type f -exec chmod +x {} \;'.
]

{ #category : #accessing }
PhLImagePackageCliCommand >> image [
	^ image
]

{ #category : #accessing }
PhLImagePackageCliCommand >> image: anImage [
	image := anImage
]

{ #category : #private }
PhLImagePackageCliCommand >> launchScriptFor: anImage [
	^ self launchScriptTemplate  
        format: (Dictionary 
            with: #IMAGE_NAME -> anImage name
            with: #VM_ID -> self vmId)

]

{ #category : #private }
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

{ #category : #'accessing arguments' }
PhLImagePackageCliCommand >> location [

	^ self positional: #location
]

{ #category : #'error signalling' }
PhLImagePackageCliCommand >> raiseDirectoryAlreadyExists: aPath [

	^PhLCommandError signal: ('Directory with the image name already exists at the location: ''{1}'', please select another location to pack image.' format: { aPath })
]

{ #category : #'accessing arguments' }
PhLImagePackageCliCommand >> shouldZip [

	^ self hasFlag: #zip
]

{ #category : #'accessing arguments' }
PhLImagePackageCliCommand >> vmId [

	(self hasFlag: #vm) ifFalse: [ ^ self defaultVmId].
	^ self positional: #vm
]
