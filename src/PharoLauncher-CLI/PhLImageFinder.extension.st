Extension { #name : #PhLImageFinder }

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> findInriaCITemplateName [
	"make sure that PR number is part of image template name"
	^ (self findTemplateNameFrom: self inriaCIArtifactUrl pathPrintString) copyReplaceAll: '-PR-' with: ('-PR-{1}-' format: { self pullRequest })
]

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

	^ self findTemplateNameFrom: self findUrl
]

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> findTemplateNameFrom: aString [

	^ (aString withoutSuffix: '.zip') copyAfterLast: $/
]

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder class >> fromInriaCIPullRequest: pullRequestString [

	^ self new
		pullRequest: pullRequestString;
		yourself
]

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> getInriaCIBuildArtifactSuffix [

	| response candidates |
	response := (PhLDownloadManager default newHTTPClientForUrl:
			             self inriaCIBuildArtifactLinkString)
		            accept: ZnMimeType textHtml;
		            get.
	"find all occurences of html links which starts with 'Pharo' and ends with 'zip'"
	candidates := response findBetweenSubstrings:
		              #( '<a href="Pharo' 'zip</a>' ).

	"this is needed, since there are more links that matches previous criteria"
	candidates := candidates select: [ :str | 
		              (str includesSubstring: 'zip') and: [ 
			              str includesSubstring: 'Pharo' ] ].

	"first of candidate links is the right build artifact"
	^ candidates first copyAfterLast: $>
]

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> getInriaCIBuildArtifactUrl [

	| suffixString |
	"get suffix with correct build artifact, containing zip archive"
	suffixString := self getInriaCIBuildArtifactSuffix.

	"return complete url referencing zip archive"
	^ ((self inriaCIBuildArtifactLinkString), suffixString, 'zip') asUrl
]

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> inriaCIArtifactUrl [
	
	^ inriaCIArtifactUrl ifNil: [ inriaCIArtifactUrl := self getInriaCIBuildArtifactUrl  ] 
]

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> inriaCIBuildArtifactLinkString [

	^ 'https://ci.inria.fr/pharo-ci-jenkins2/job/Test%20pending%20pull%20request%20and%20branch%20Pipeline/view/change-requests/job/PR-{1}/lastSuccessfulBuild/artifact/bootstrap-cache/' 
		  format: { self pullRequest }
]

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> pullRequest [
	
	^ pullRequest 
]

{ #category : #'*PharoLauncher-CLI' }
PhLImageFinder >> pullRequest: aString [
	
	pullRequest := aString
]
