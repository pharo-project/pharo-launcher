Extension { #name : #PhLImageFinder }

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> findTemplateName [

	^ (self findUrl withoutSuffix: '.zip') copyAfterLast: $/
]
