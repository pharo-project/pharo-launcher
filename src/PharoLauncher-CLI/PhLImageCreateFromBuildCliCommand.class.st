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

{ #category : #creating }
PhLImageCreateFromBuildCliCommand >> createNewImageDirectoryInDefaultImageLocation [
	(PhLDirectoryBasedImageRepository defaultLocation / self targetName)
		asFileReference ensureCreateDirectory
]

{ #category : #download }
PhLImageCreateFromBuildCliCommand >> downloadZip: url [
	PhLDownloadManager new
		basicDownload: url
		toFile: self zipFile.
]

{ #category : #'command execution' }
PhLImageCreateFromBuildCliCommand >> execute [
	| url newImageTemplateZip |
	url := self findURLOfPharo: self pharoVersionNumber build: self buildNumber.
	self downloadZip: url.
	self createNewImageDirectoryInDefaultImageLocation.
	newImageTemplateZip := PhLLocalTemplate name: self targetName zipFile: self zipFile.
	[newImageTemplateZip extractTo: self imageDirectory named: self targetName]  on: FileExists do: [ self outStream nextPutAll: 'An image already have that name, please choose another one'].
	self zipFile delete
	
	
]

{ #category : #'finding/searching' }
PhLImageCreateFromBuildCliCommand >> findSHAOfPharo: aPharoVersion build: aBuildNumber [ 
	| urlTable begin stringIncludingUrl url SHA |
	urlTable := (ZnClient new get: 'https://files.pharo.org/image/', aPharoVersion,'0/') lines.
	1 to: urlTable size do: [ :index | 
		(((urlTable at: index) includesSubstring: 'build.',aBuildNumber)
			and: [ (urlTable at: index) includesSubstring: '64bit' ])
			ifTrue: [ stringIncludingUrl := urlTable at: index ] ].
	begin := stringIncludingUrl findString: 'sha.'.
	SHA := stringIncludingUrl copyFrom: (begin +4) to: (begin+10).  
	^ SHA
	
]

{ #category : #'finding/searching' }
PhLImageCreateFromBuildCliCommand >> findURLOfPharo: aPharoVersion build: aBuildNumber [
	| url pharoVersion |
	pharoVersion := aPharoVersion.
	pharoVersion = '10'
		ifFalse: [ pharoVersion := pharoVersion , '.0' ].
	pharoVersion = '7.0'
		ifTrue: [ pharoVersion := '-' , pharoVersion , '.0-alpha' ]
		ifFalse: [ pharoVersion := pharoVersion , '-SNAPSHOT' ].
	url := 'https://files.pharo.org/image/' , aPharoVersion , '0/Pharo'
		, pharoVersion , '.build.' , aBuildNumber , '.sha.' , (self
		findSHAOfPharo: aPharoVersion
		build: aBuildNumber) , '.arch.64bit.zip'.
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

{ #category : #filenames }
PhLImageCreateFromBuildCliCommand >> zipFile [
	^ ((FileLocator temp / ('FileAttributesTests-', UUIDGenerator next asString, '.zip')) resolve)
]
