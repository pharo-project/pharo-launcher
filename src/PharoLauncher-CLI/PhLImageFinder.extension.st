Extension { #name : #PhLImageFinder }

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder class >> findLatestPharoDevelopmentVersion [
	|response candidates|
	"very ugly way to determine latest Pharo dev version - but it works"
	response := (PhLDownloadManager default newHTTPClientForUrl: 'https://files.pharo.org/image/')
accept: ZnMimeType textHtml;
 get.
	candidates := response lines select: [ :l | l includesSubstring: '/</a>' caseSensitive: false ] thenCollect: [ :line | (line findBetweenSubstrings: #('<a href="'  '/</a>')) second].
	candidates := candidates collect: [:str | str copyAfterLast: $> ] thenSelect: [:str| str isAllDigits].
	candidates ifNotEmpty: [:aColl | 
		candidates := aColl collect: [:aString | aString allButLast asNumber].
		^ candidates max asString
		 ]
	ifEmpty: [ self error: 'Could not retrieve latest development version of Pharo from: files.pharo.org.' ]
	
]

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> findTemplateName [

	^ (self findUrl withoutSuffix: '.zip') copyAfterLast: $/
]
