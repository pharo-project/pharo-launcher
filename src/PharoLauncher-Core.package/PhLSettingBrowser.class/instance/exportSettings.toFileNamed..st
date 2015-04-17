private
exportSettings: aCollection toFileNamed: filename
	aCollection do: [ :startupAction | startupAction runOnce: false ].
	StartupPreferencesLoader default addAtStartup: aCollection inDirectory: self class preferencesFolder named: filename