private
exportLDLibraryPathCommandWith: vmDirectoryPath
	^ 'export LD_LIBRARY_PATH=' ,
		($: join: ((self cleanLDLibraryPath copyWithFirst: vmDirectoryPath) collect: #surroundedBySingleQuotes))
