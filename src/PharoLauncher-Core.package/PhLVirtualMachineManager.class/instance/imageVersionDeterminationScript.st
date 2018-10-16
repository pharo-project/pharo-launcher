private
imageVersionDeterminationScript
	| imageFolder |

	SystemVersion current major isNil "Pharo 1.1"
		ifTrue: [ SystemVersion current major: 1. 
					SystemVersion current minor: 1 ]. 

	(SystemVersion current major = 1 and: [ SystemVersion current minor < 4 ])
		ifTrue: [ imageFolder := (Smalltalk at: #FileDirectory) on: Smalltalk imagePath.
			imageFolder forceNewFileNamed: 'pharo.version' do: [ :stream |
				stream 
					<< SystemVersion current major;
					<< SystemVersion current minor ] ]
		ifFalse: [ imageFolder := Smalltalk imagePath asFileReference. 
			SystemVersion current major = 1
				ifFalse: [ imageFolder := imageFolder parent ].
			imageFolder / 'pharo.version' 
				writeStreamDo: [ :stream | |major minor|
					major := SystemVersion current major.
					minor := SystemVersion current minor.
					"Pharo 6 images >= 60509 need 61 VM, even though the image states 60"
					(major = 6 and: [ SystemVersion current highestUpdate >= 60509 ])
						ifTrue: [ minor := 1 ].
					stream 
						<< major asString;
						<< minor asString ] ].
	Smalltalk snapshot: false andQuit: true