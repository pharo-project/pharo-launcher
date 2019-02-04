Extension { #name : #LGitLibrary }

{ #category : #'*PharoLauncher-Core' }
LGitLibrary >> unixModuleName [
	| pluginDir |
	pluginDir := Smalltalk vm directory asFileReference.
	#('libgit2.so' 'libgit2.so.0')
		detect: [ :each | (pluginDir / each) exists ] 
		ifFound: [ :libName | ^ libName ].

	self error: 'Module not found.'
]
