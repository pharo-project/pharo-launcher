"
Represent a list of templates as given by an HTML webpage. <a href=""*.zip""> are searched in the webpage.
"
Class {
	#name : #PhLHTTPListingTemplateGroup,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'url',
		'name',
		'templateNameFormat'
	],
	#classVars : [
		'RegexCache'
	],
	#category : #'PharoLauncher-Core-Model'
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

{ #category : #'instance creation' }
PhLHTTPListingTemplateGroup class >> name: aString url: anUrl filterPattern: aPatternString templateNameFormat: aNameFormat username: anotherString password: yetAnotherString [
	^ (self name: aString url: anUrl filterPattern: aPatternString)
		  username: anotherString;
		  password: yetAnotherString;
		  templateNameFormat: aNameFormat;
		  yourself
]

{ #category : #'instance creation' }
PhLHTTPListingTemplateGroup class >> name: aString url: anUrl filterPattern: aPatternString username: anotherString password: yetAnotherString [
	^ (self name: aString url: anUrl filterPattern: aPatternString)
		  username: anotherString;
		  password: yetAnotherString;
		  yourself
]

{ #category : #'instance creation' }
PhLHTTPListingTemplateGroup class >> name: aString url: anUrl username: anotherString password: yetAnotherString [
	^ (self name: aString url: anUrl)
		  username: anotherString;
		  password: yetAnotherString;
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
	| templateName urlFile |
	templateNameFormat 
		ifNil: [ templateName := filename copyUpToLast: $..
			urlFile := url / filename ]
		ifNotNil: [ templateName := templateNameFormat formatTemplateName: filename. 
			urlFile := url clearPath / filename ].
	templates add: (PhLRemoteTemplate name: templateName url: urlFile)
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
PhLHTTPListingTemplateGroup >> password [
	^ url password
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> password: aString [
	^ url password: aString
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> regex [
	^ self class regexCache at: self name asSymbol 
]

{ #category : #initialization }
PhLHTTPListingTemplateGroup >> setName: aName url: anUrl [
	name := aName.
	url := anUrl.
	self class regexCache at: aName asSymbol put: (RxParser parse: self class defaultFilterPattern) 
]

{ #category : #initialization }
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
PhLHTTPListingTemplateGroup >> templateNameFormat [
	^ templateNameFormat
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> templateNameFormat: anObject [
	templateNameFormat := anObject
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

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> username [
	^ url username
]

{ #category : #accessing }
PhLHTTPListingTemplateGroup >> username: aString [
	url username: aString
]
