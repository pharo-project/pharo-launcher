initialize-release
originTemplate
self haltOnce.
	^ self meta at: #template ifAbsent: [ nil ]