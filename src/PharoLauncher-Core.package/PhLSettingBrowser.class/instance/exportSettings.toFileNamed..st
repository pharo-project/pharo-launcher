private
exportSettings: aCollection toFileNamed: filename
	StartupPreferencesLoader default addAtStartup: aCollection inDirectory: self preferencesFolder named: filename