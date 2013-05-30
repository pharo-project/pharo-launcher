accessing
artifacts
	| runs |
	runs := (json at: #lastSuccessfulBuild) at: #runs.
	^ runs gather: [:run | self artifactsFromRun: run]