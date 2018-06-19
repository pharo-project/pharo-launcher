tests
testCanListIntalledPackages
	| list |
	list := PhLAboutCommand new launcherPackageList.
	self 
		assert: list size 
		equals: 5.
	self 
		assertCollection: (PhLAboutCommand new launcherPackageList collect: [ :s | s copyUpToLast: $- ])
		 hasSameElements: #( 'PharoLauncher-Core'
								'PharoLauncher-Download' 
								'PharoLauncher-Spec'
								'PharoLauncher-Tests-Core'
								'PharoLauncher-Tests-Download' )