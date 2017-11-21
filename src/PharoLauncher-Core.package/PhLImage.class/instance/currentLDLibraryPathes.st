private
currentLDLibraryPathes
	^ ((OSEnvironment current getEnv: 'LD_LIBRARY_PATH') ifNil: [ '' ])
		substrings: ':'