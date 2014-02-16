private
exportSettings: aCollection toFileNamed: filename
	StartupPreferencesLoader default addAtStartup: aCollection inDirectory: self class preferencesFolder named: filename