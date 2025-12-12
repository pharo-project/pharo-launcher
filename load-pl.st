Metacello new
    repository: 'github://pharo-spec/Spec:Pharo13-launcher-gtk';
    baseline: 'Spec2';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load;
    lock.
Metacello new
    repository: 'github://pharo-spec/Spec:Pharo13-launcher-gtk';
    baseline: 'SpecCore';
    lock.
"Use latest release of UFFI"
Metacello new
	repository: 'github://pharo-cig/UnifiedFFI:v1.2';
	baseline: 'UnifiedFFIFull';
	onConflict: [ :n | n useIncoming ];
	onUpgrade: [ :n | n useIncoming ];
	ignoreImage;
	load.

Metacello new
    repository: 'github://pharo-project/pharo-launcher:pharo13-gtk';
    baseline: 'PharoLauncher';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load.

"Need the following fix since Monticello does not do the job"
(Smalltalk at: #GEnumeration) allSubclassesDo: #initializeEnumeration