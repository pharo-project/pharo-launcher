Metacello new
    repository: 'github://pharo-project/pharo-launcher:pharo14-gtk';
    baseline: 'PharoLauncher';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load.

"Enumeration init is already performed by BaselineOfGtk; guard defensively"
Smalltalk classNamed: #GEnumeration ifPresent: [ :enumerationClass | 
	enumerationClass allSubclassesDo: #initializeEnumeration ]