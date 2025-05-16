"temporary fix: see https://github.com/pharo-project/pharo/pull/18167"
MCGitBasedNetworkRepository compile: 'projectVersion
	^ projectVersion'.

Metacello new
    repository: 'github://pharo-spec/Spec';
    baseline: 'Spec2';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load;
    lock.
Metacello new
    repository: 'github://pharo-spec/Spec';
    baseline: 'SpecCore';
    lock.

Metacello new
    repository: 'github://pharo-project/pharo-launcher:pharo13-gtk';
    baseline: 'PharoLauncher';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load.