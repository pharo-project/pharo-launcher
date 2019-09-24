"
Represent a list of templates as given by an HTML webpage. <a href=""*.zip""> are searched in the webpage.
"
Class {
	#name : #PhLHTTPListingTemplateGroup,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'url',
		'name'
	],
	#classVars : [
		'RegexCache'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #defaults }
PhLHTTPListingTemplateGroup class >> defaultFilterPattern [
	"Returns the default filter pattern (Pharo6). The parenthesis here are important because this is what we want to extract for each match. The #subexpression must correspond to the index of this pair of parenthesis"
	^'href="([^"]*.zip)"' 
]

{ #category : #'instance creation' }
PhLHTTPListingTemplateGroup class >> name: aString url: anUrl [
	^ self new
		setName: aString url: anUrl;
		yourself
]

{ #category : #'instance creation' }
PhLHTTPListingTemplateGroup class >> name: aString url: anUrl filterPattern: aPatternString [
	^ self new
		setName: aString url: anUrl filterPattern: aPatternString;
		yourself
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup class >> regexCache [
	"Cache the regex per version so that we don't recompute it all the time"
	^ RegexCache ifNil: [ RegexCache := Dictionary new ]
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup class >> subexpression [
	"Index of the #regex subexpression (delimited by parenthesis) we are interested in. See 'usage' documentation at RxParser"
	^ 2
]

{ #category : #private }
PhLHTTPListingTemplateGroup >> createTemplateFromHref: filename addingTo: templates [
	| templateName |
	templateName := filename copyUpToLast: $..
	templates add: (PhLRemoteTemplate name: templateName url: url / filename)
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> icon [
	^ self iconNamed: #remote
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> name [
	^ name
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> regex [
	^ self class regexCache at: self name asSymbol 
]

{ #category : #'initialize-release' }
PhLHTTPListingTemplateGroup >> setName: aName url: anUrl [
	name := aName.
	url := anUrl.
	self class regexCache at: aName asSymbol put: (RxParser parse: self class defaultFilterPattern) 
]

{ #category : #'initialize-release' }
PhLHTTPListingTemplateGroup >> setName: aName url: anUrl filterPattern: aPatternString [
	name := aName.
	url := anUrl.
	self class regexCache at: aName asSymbol put: (RxParser parse: aPatternString)
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> subexpression [
	^ self class subexpression
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> templatesAndGroups [
	| content matcher templates |
	content := PhLDownloadManager default downloadToPositionableStream: url mimeType: ZnMimeType textHtml. 
	matcher := RxMatcher for: self regex.
	templates := OrderedCollection new.
	[ matcher searchStream: content ] whileTrue: 
		[ self createTemplateFromHref: (matcher subexpression: self subexpression)  addingTo: templates ].
	^ templates
	
]
