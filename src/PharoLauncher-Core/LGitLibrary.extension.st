Extension { #name : #LGitLibrary }

{ #category : #'*PharoLauncher-Core' }
LGitLibrary class >> startUp: isImageStarting [
	"avoid init error with libgit. See https://github.com/pharo-project/pharo/issues/4463"
	(isImageStarting and: [ PharoLauncherApplication isDeployed not ])
		ifTrue: [ self uniqueInstance initializeLibGit2 ]
]

{ #category : #'*PharoLauncher-Core' }
LGitLibrary >> unixModuleName [
	| pluginDir |
	pluginDir := Smalltalk vm directory asFileReference.
	#('libgit2.so' 'libgit2.so.0')
		detect: [ :each | (pluginDir / each) exists ] 
		ifFound: [ :libName | ^ libName ].

	self error: 'Module not found.'
]
