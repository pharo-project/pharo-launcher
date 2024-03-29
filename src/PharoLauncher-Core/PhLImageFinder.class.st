"
I can be used to find the URL of a Pharo image given the Pharo version and a build number or a sha referencing a Pharo version in the git repository.
It is generally useful to detect problems in a specific Pharo image build.
"
Class {
	#name : #PhLImageFinder,
	#superclass : #Object,
	#instVars : [
		'pharoVersion',
		'build',
		'sha',
		'pullRequest',
		'inriaCIArtifactUrl'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #'finding/searching' }
PhLImageFinder class >> buildsForPharoVersion: pharoVersion [

	^ (self pharoVersion: pharoVersion build: '1') buildNumbers
]

{ #category : #accessing }
PhLImageFinder class >> defaultArchitectureString [
	"pattern used to search default templates"
	^ '64bit'
]

{ #category : #'finding/searching' }
PhLImageFinder class >> findLatestPharoDevelopmentVersion [

	| response candidates |
	"very ugly way to determine latest Pharo dev version - but it works"
	response := (PhLDownloadManager default newHTTPClientForUrl:
			             'https://files.pharo.org/image/')
		            accept: ZnMimeType textHtml;
		            get.
	candidates := response lines
		              select: [ :l | l includesSubstring: '/</a>' caseSensitive: false ]
		              thenCollect: [ :line | (line findBetweenSubstrings: #( '<a href="' '/</a>' )) second ].
	candidates := candidates
		              collect: [ :str | str copyAfterLast: $> ]
		              thenSelect: [ :str | str isAllDigits ].
	candidates
		ifEmpty: [ self error: 'Could not retrieve latest development version of Pharo from: files.pharo.org.' ].
		
	^ (candidates collect: [ :aString | aString allButLast asNumber ]) max asString
]

{ #category : #'instance creation' }
PhLImageFinder class >> fromInriaCIPullRequest: pullRequestString [

	^ self new
		pullRequest: pullRequestString;
		yourself
]

{ #category : #'instance creation' }
PhLImageFinder class >> pharoVersion: aPharoVersionString build: aPharoImageBuildNumberString [
	^ self new
		pharoVersion: aPharoVersionString build: aPharoImageBuildNumberString;
		yourself
]

{ #category : #'instance creation' }
PhLImageFinder class >> pharoVersion: aPharoVersionString sha: aPharoImageSha [
	^ self new
		pharoVersion: aPharoVersionString sha: aPharoImageSha;
		yourself
]

{ #category : #accessing }
PhLImageFinder >> buildNumber [
	^ build
]

{ #category : #'finding/searching' }
PhLImageFinder >> buildNumbers [

	| matcher imagesListing builds |
	imagesListing := self htmlListingFor: self imageHtmlListingUrl.
	matcher := self imageMatcherWithImageRegex: 'build\.([0-9]+)\.sha\.'.
	builds := imagesListing lines 
		select: [ :line | matcher matchesPrefix: line ]
		thenCollect: [ :line | (matcher subexpression: 4) asInteger "build number"].
	^ builds sorted
]

{ #category : #'finding/searching' }
PhLImageFinder >> findTemplateUrlForRemoteArtifact [

	^ (self pullRequestBuildArtifactsUrlString, self templateArtifactName) asUrl
]

{ #category : #'finding/searching' }
PhLImageFinder >> findUrl [
	| imagesListing templates matcher buildOrShaFilter imageListingUrl |
	
	imageListingUrl := self imageHtmlListingUrl.
	imagesListing := self htmlListingFor: imageListingUrl.
	buildOrShaFilter := self buildNumber 
		ifNil: [ '.sha.' , self sha , '.' ]
		ifNotNil: [ 'build.' , self buildNumber, '.sha.' ].
	templates := imagesListing lines 
		select: [ :line | 
			(line includesSubstring: buildOrShaFilter) 
				and: [ line includesSubstring: self class defaultArchitectureString ]].
	buildOrShaFilter := self buildNumber 
		ifNil: [ 'build\..+\.sha\.' , self sha , '\.' ]
		ifNotNil: [ 'build\.' , self buildNumber, '\.sha\.' ].
	matcher := self imageMatcherWithImageRegex: buildOrShaFilter.
	templates detect: [ :template | matcher matchesPrefix: template ].
	^ imageListingUrl , (matcher subexpression: 2)
]

{ #category : #fetching }
PhLImageFinder >> htmlListingFor: url [
	^ ZnClient new get: url
]

{ #category : #accessing }
PhLImageFinder >> imageHtmlListingUrl [
	^ 'https://files.pharo.org/image/', self pharoVersion , '0/'
]

{ #category : #private }
PhLImageFinder >> imageMatcherWithImageRegex: imageRegex [
	
	^ ('.*href="(Pharo-?[0-9]+[.0]*-(SNAPSHOT|alpha)\.', imageRegex , '[^"]*64bit\.zip)"') asRegex.

]

{ #category : #accessing }
PhLImageFinder >> inriaCIArtifactUrl [
	
	^ inriaCIArtifactUrl ifNil: [ inriaCIArtifactUrl := self findTemplateUrlForRemoteArtifact  ] 
]

{ #category : #private }
PhLImageFinder >> pharoPRBuildArtifactsHtml [

	"returns html page with build artifacts content for given PR"

	^ (PhLDownloadManager default newHTTPClientForUrl:
			   self pullRequestBuildArtifactsUrlString)
		  accept: ZnMimeType textHtml;
		  get
]

{ #category : #accessing }
PhLImageFinder >> pharoVersion [
	^ pharoVersion
]

{ #category : #initialization }
PhLImageFinder >> pharoVersion: aPharoVersionString build: aPharoImageBuildNumberString [
	pharoVersion := aPharoVersionString.
	build := aPharoImageBuildNumberString
]

{ #category : #initialization }
PhLImageFinder >> pharoVersion: aPharoVersionString sha: aPharoImageSha [
	pharoVersion := aPharoVersionString.
	sha := aPharoImageSha 
]

{ #category : #accessing }
PhLImageFinder >> pharoVersionForImageListing [
	
	^ pharoVersion asNumber < 10
		ifTrue: [ pharoVersion , '.0' ]
		ifFalse: [ pharoVersion ]
]

{ #category : #accessing }
PhLImageFinder >> pullRequest [
	
	^ pullRequest 
]

{ #category : #accessing }
PhLImageFinder >> pullRequest: aString [
	
	pullRequest := aString
]

{ #category : #private }
PhLImageFinder >> pullRequestBuildArtifactsUrlString [

	^ 'https://ci.inria.fr/pharo-ci-jenkins2/job/Test%20pending%20pull%20request%20and%20branch%20Pipeline/view/change-requests/job/PR-{1}/lastSuccessfulBuild/artifact/build/bootstrap-cache/' 
		  format: { self pullRequest }
]

{ #category : #accessing }
PhLImageFinder >> sha [ 
	^ sha
]

{ #category : #private }
PhLImageFinder >> templateArtifactName [

	| candidates |
	
	"find all occurences of html links which starts with 'Pharo' and ends with 'zip'"
	candidates := self pharoPRBuildArtifactsHtml findBetweenSubstrings: #( '<a href="Pharo' 'zip</a>' ).

	"this is needed, since there are more links that matches previous criteria"
	candidates := candidates select: [ :str | 
		              (str includesSubstring: 'zip') and: [ 
			              str includesSubstring: 'Pharo' ] ].

	"first of candidate links is the right build artifact"
	^ (candidates first copyAfterLast: $>) , 'zip'
]
