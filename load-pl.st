Metacello new
    repository: 'github://pharo-spec/Spec:Pharo13';
    baseline: 'Spec2';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load;
    lock.
Metacello new
    repository: 'github://pharo-spec/Spec:Pharo13';
    baseline: 'SpecCore';
    lock.

Metacello new
    repository: 'github://pharo-project/pharo-launcher:pharo13-gtk';
    baseline: 'PharoLauncher';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load.