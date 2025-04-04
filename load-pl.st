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

"temporary fix for Iceberg: see issue https://github.com/pharo-vcs/iceberg/issues/1921"
IceRepositoryCreator compile: 'cloneRepository
	IceGitClone new
		location: self locationToUse;
		url: self remoteToUse url;
		execute.

	self repository location: self locationToUse.
	self commitishName 
		ifNotNil: [ self repository switchToCommitishNamed: self commitishName ].

	self repository pluginManager repositoryWillBeCreated: self repository.	

	self repository workingCopy initializePackagesFromRepository.
	self doEnsureProject.
		
	self repository pluginManager repositoryWasCreated: self repository.
	^ self repository'.

Metacello new
    repository: 'github://pharo-project/pharo-launcher:pharo13-gtk';
    baseline: 'PharoLauncher';
    onConflict: [ :e | e useIncoming ];
    onUpgrade: [ :e | e useIncoming ];
    ignoreImage;
    load.