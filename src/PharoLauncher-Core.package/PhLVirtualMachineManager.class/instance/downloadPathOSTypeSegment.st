private
downloadPathOSTypeSegment
	| os |
	os := Smalltalk os.
	(os isMacOS or: [ os isMacOSX ]) ifTrue: [ ^ 'mac' ].	
	os isUnix ifTrue: [ ^ 'linux' ].
	os isWindows ifTrue: [ ^ 'win' ].
