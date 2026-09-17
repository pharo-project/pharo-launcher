Metacello new
    repository: 'github://pharo-project/pharo-launcher:fix-ci';
    baseline: 'PharoLauncher';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load.

"Enumeration init is already performed by BaselineOfGtk; guard defensively"
(Smalltalk classNamed: #GEnumeration)
	ifNotNil: [ :enumerationClass |
		enumerationClass allSubclassesDo: #initializeEnumeration ]