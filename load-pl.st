"Load the launcher from the checked out sources (run from the repository root), not from a fixed branch"
Metacello new
    repository: 'tonel://' , (FileSystem workingDirectory / 'src') fullName;
    baseline: 'PharoLauncher';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load.

"Enumeration init is already performed by BaselineOfGtk; guard defensively"
(Smalltalk classNamed: #GEnumeration)
	ifNotNil: [ :enumerationClass |
		enumerationClass allSubclassesDo: #initializeEnumeration ]