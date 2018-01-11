tests
testCanListIntalledPackages
	| list |
	list := PhLAboutCommand new launcherPackageList.
	self 
		assert: list size 
		equals: 3.
	self 
		assertCollection: (PhLAboutCommand new launcherPackageList collect: [ :s | s copyUpToLast: $- ])
		 hasSameElements: #( 'PharoLauncher-Core'
									'PharoLauncher-Spec'
									'PharoLauncher-Tests-Core' )