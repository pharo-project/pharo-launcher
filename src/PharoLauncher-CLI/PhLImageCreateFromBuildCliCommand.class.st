Class {
	#name : #PhLImageCreateFromBuildCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #createFromBuild 
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdDescription [
	^ 'Downloads and creates new image on local computer from remote site based on a Pharo version number a build number and an SHA (would be better without but not possible for the moment) .'
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdPositionals [

	^ {
		((ClapPositional id: #pharoVersionNumber)
				description: 'the number of the Pharo version you want to use';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'one argument is missing, there is no Pharo version for the new image' .   ];
					yourself)	.
		((ClapPositional id: #build)
				description: 'build number of the template to download';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app |  ];
					yourself).
		((ClapPositional id: #SHA)
				description: 'SHA of the template';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app |  ];
					yourself).
		((ClapPositional id: #newImageName)
				description: 'name of the new image';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app |  ];
					yourself)
	}
]

{ #category : #helpers }
PhLImageCreateFromBuildCliCommand >> SHA [
	^ (arguments at: #SHA) word
]

{ #category : #helpers }
PhLImageCreateFromBuildCliCommand >> buildNumber [
	^ (arguments at: #build) word
]

{ #category : #'as yet unclassified' }
PhLImageCreateFromBuildCliCommand >> createNewImageDirectoryInDefaultImageLocation [
	(PhLDirectoryBasedImageRepository defaultLocation / self targetName)
		asFileReference ensureCreateDirectory
]

{ #category : #'as yet unclassified' }
PhLImageCreateFromBuildCliCommand >> downloadZip: url [
	PhLDownloadManager new
		basicDownload: url
		toFile: self zipFile.
]

{ #category : #'command execution' }
PhLImageCreateFromBuildCliCommand >> execute [
	| url newImageTemplateZip |
	url := self findURLOf: self pharoVersionNumber build: self buildNumber withSHA: self SHA.
	self downloadZip: url.
	self createNewImageDirectoryInDefaultImageLocation.
	newImageTemplateZip := PhLLocalTemplate name: self targetName zipFile: self zipFile.
	newImageTemplateZip extractTo: self imageDirectory named: self targetName.
	self zipFile delete
	
	
]

{ #category : #'finding/searching' }
PhLImageCreateFromBuildCliCommand >> findURLOf: aPharoVersion build: aBuildNumber withSHA: aSha [
	| url pharoVersion |
	pharoVersion := aPharoVersion.
	pharoVersion = '10'
		ifFalse: [ pharoVersion := pharoVersion , '.0' ].
	pharoVersion = '7.0'
		ifTrue: [ pharoVersion := '-' , pharoVersion , '.0-alpha' ]
		ifFalse: [ pharoVersion := pharoVersion , '-SNAPSHOT' ].
	url := 'https://files.pharo.org/image/' , aPharoVersion , '0/Pharo'
		, pharoVersion , '.build.' , aBuildNumber , '.sha.' , aSha
		, '.arch.64bit.zip'.
	^ url
]

{ #category : #origins }
PhLImageCreateFromBuildCliCommand >> imageDirectory [
	^ ( PhLDirectoryBasedImageRepository defaultLocation / self targetName ) asFileReference 
]

{ #category : #helpers }
PhLImageCreateFromBuildCliCommand >> pharoVersionNumber [
	^ (arguments at: #pharoVersionNumber) word
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> targetName [
	^ (arguments at: #newImageName) word
]

{ #category : #'as yet unclassified' }
PhLImageCreateFromBuildCliCommand >> zipFile [
	^ '/tmp/pharoDownloadImageTemp968553514446844756' asFileReference
]
