Extension { #name : #FFILibraryFinder }

{ #category : #'*PharoLauncher-Tests-Functional' }
FFILibraryFinder >> findAnyLibrary: aCollection [

self traceCr: '[FFILibraryFinder] Smalltalk imageDirectory fullName = ', Smalltalk imageDirectory fullName.
self traceCr: '[FFILibraryFinder] Smalltalk vm directory = ', Smalltalk vm directory.
	aCollection do: [ :eachName |
		self paths do: [ :each | | path |
			path := each / eachName.
			self traceCr: '[FFILibraryFinder] searching ', path fullName. 
			path exists
				ifTrue: [ self traceCr: '[FFILibraryFinder] searching ', path fullName. ^ path fullName ] ] ].
self traceCr: 'flush'.
	self error: ('Cannot locate any of {1}. Please check if it installed on your system' format: { aCollection asString })
]
