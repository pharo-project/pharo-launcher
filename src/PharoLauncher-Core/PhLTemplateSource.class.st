"
I represent a source for templates used by Pharo Launcher to create an image.
	type could be a value between: jenkins, URL, http listing, cache, etc.

I'm just a state holder easily serializable with Ston 
"
Class {
	#name : #PhLTemplateSource,
	#superclass : #Object,
	#instVars : [
		'type',
		'name',
		'url',
		'filterPattern',
		'templates',
		'expanded',
		'username',
		'password'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation - cache' }
PhLTemplateSource class >> cacheGroup [
	^ self new 	
		type: self cacheType;
		name: 'Templates';
		yourself
]

{ #category : #types }
PhLTemplateSource class >> cacheType [
	^ #Cache
]

{ #category : #'instance creation - url deprecated' }
PhLTemplateSource class >> deprecatedDistributionsGroup [
	^ self new 	
		type: self urlGroupType;
		name: 'Deprecated distributions';
		templates: { self pharo40 .
				self pharo30 .
				self pharo20 .
				self moose51 .
				self moose50 };
		yourself
]

{ #category : #types }
PhLTemplateSource class >> httpGithubReleaseType [
	^ #HttpGithubRelease
]

{ #category : #types }
PhLTemplateSource class >> httpListingType [
	^ #HttpListing
]

{ #category : #'instance creation - jenkins' }
PhLTemplateSource class >> inriaMoose [
	^ self new 	
		type: self jenkinsServerType;
		name: 'Moose Jenkins';
		url: 'https://ci.inria.fr/moose';
		yourself
]

{ #category : #'instance creation - jenkins' }
PhLTemplateSource class >> inriaPharoContribution [
	^ self new 	
		type: self jenkinsServerType;
		name: 'Pharo Contribution Jenkins';
		url: 'https://ci.inria.fr/pharo-contribution';
		yourself
]

{ #category : #'instance creation - jenkins' }
PhLTemplateSource class >> inriaRmod [
	^ self new 	
		type: self jenkinsServerType;
		name: 'RMoD Jenkins';
		url: 'https://ci.inria.fr/rmod';
		yourself
]

{ #category : #types }
PhLTemplateSource class >> jenkinsServerType [
	^ #JenkinsServer
]

{ #category : #'instance creation - url mooc' }
PhLTemplateSource class >> moocGroup [
	^ self new 	
		type: self urlGroupType;
		name: 'Pharo Mooc';
		templates: { self pharoMooc };
		yourself
]

{ #category : #'instance creation - url deprecated' }
PhLTemplateSource class >> moose50 [
	^ self new 	
		type: self urlType;
		name: 'Moose Suite 5.0';
		url: 'http://moosetechnology.org/res/download/moose_image_5_0.zip';
		yourself
]

{ #category : #'instance creation - url deprecated' }
PhLTemplateSource class >> moose51 [
	^ self new 	
		type: self urlType;
		name: 'Moose Suite 5.1 (old stable)';
		url: 'https://ci.inria.fr/moose/job/moose-5.1/lastSuccessfulBuild/artifact/moose-5.1.zip';
		yourself
]

{ #category : #'instance creation - url official' }
PhLTemplateSource class >> moose60 [
	^ self new 	
		type: self urlType;
		name: 'Moose Suite 6.0 (stable)';
		url: 'https://ci.inria.fr/moose/job/moose-6.0/lastSuccessfulBuild/artifact/moose-6.0.zip';
		yourself
]

{ #category : #'instance creation - url official' }
PhLTemplateSource class >> moose61 [
	^ self new 	
		type: self urlType;
		name: 'Moose Suite 6.1 (beta)';
		url: 'https://ci.inria.fr/moose/job/moose-6.1/lastSuccessfulBuild/artifact/moose-6.1.zip';
		yourself
]

{ #category : #'instance creation - url official' }
PhLTemplateSource class >> officialDistributionsGroup [
	^ self new 	
		type: self urlGroupType;
		name: 'Official distributions';
		templates: { self pharo70x32 .
				self pharo70x64 .
				self pharo60x32 .
				self pharo60x64 .
				self pharo50 .
				self moose61 .
				self moose60 };
		expanded: true;
		yourself
]

{ #category : #'instance creation - url deprecated' }
PhLTemplateSource class >> pharo20 [
	^ self new 	
		type: self urlType;
		name: 'Pharo 2.0';
		url: 'http://files.pharo.org/image/20/latest.zip';
		yourself
]

{ #category : #'instance creation - url deprecated' }
PhLTemplateSource class >> pharo30 [
	^ self new 	
		type: self urlType;
		name: 'Pharo 3.0';
		url: 'http://files.pharo.org/image/30/latest.zip';
		yourself
]

{ #category : #'instance creation - url deprecated' }
PhLTemplateSource class >> pharo40 [
	^ self new 	
		type: self urlType;
		name: 'Pharo 4.0';
		url: 'http://files.pharo.org/image/40/latest.zip';
		yourself
]

{ #category : #'instance creation - url official' }
PhLTemplateSource class >> pharo50 [
	^ self new 	
		type: self urlType;
		name: 'Pharo 5.0';
		url: 'http://files.pharo.org/image/50/latest.zip';
		yourself
]

{ #category : #'instance creation - http listing' }
PhLTemplateSource class >> pharo60 [
	^ self new 	
		type: self httpListingType;
		name: 'Pharo 6.0 (stable)'; 
		url: 'http://files.pharo.org/image/60/';
		yourself
]

{ #category : #'instance creation - url official' }
PhLTemplateSource class >> pharo60x32 [
	^ self new 	
		type: self urlType;
		name: 'Pharo 6.1 - 32bit (stable)';
		url: 'http://files.pharo.org/image/60/latest.zip';
		yourself
]

{ #category : #'instance creation - url official' }
PhLTemplateSource class >> pharo60x64 [
	^ self new 	
		type: self urlType;
		name: 'Pharo 6.1 - 64bit (tech preview)';
		url: 'http://files.pharo.org/image/60/latest-64.zip';
		yourself
]

{ #category : #'instance creation - http listing' }
PhLTemplateSource class >> pharo70 [
	^ self new 	
		type: self httpListingType;
		name: 'Pharo 7.0 (development version)'; 
		url: 'http://files.pharo.org/image/70/';
		filterPattern: 'href="(Pharo-?7.0.0-(alpha|rc\d+).build.[^"]*.zip)"';
		yourself
]

{ #category : #'instance creation - url official' }
PhLTemplateSource class >> pharo70x32 [
	^ self new 	
		type: self urlType;
		name: 'Pharo 7.0 - 32bit (development version)';
		url: 'http://files.pharo.org/image/70/latest.zip';
		yourself
]

{ #category : #'instance creation - url official' }
PhLTemplateSource class >> pharo70x64 [
	^ self new 	
		type: self urlType;
		name: 'Pharo 7.0 - 64bit (development version)';
		url: 'http://files.pharo.org/image/70/latest-64.zip';
		yourself
]

{ #category : #'instance creation - url mooc' }
PhLTemplateSource class >> pharoMooc [
	^ self new
		type: self urlType;
		name: 'Pharo Mooc';
		url: 'http://mooc.pharo.org/image/PharoWeb.zip';
		yourself
]

{ #category : #types }
PhLTemplateSource class >> urlGroupType [
	^ #URLGroup
]

{ #category : #types }
PhLTemplateSource class >> urlType [
	^ #URL
]

{ #category : #comparing }
PhLTemplateSource >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject name
		and: [ type = anObject type 
		and: [ url = anObject url
		and: [ filterPattern = anObject filterPattern
		and: [ templates = anObject templates
		and: [ self expanded = anObject expanded ] ] ] ] ]
]

{ #category : #converting }
PhLTemplateSource >> asBasicTemplateGroup [
	type == self class httpListingType
		ifTrue: [ | pattern |
					pattern := filterPattern ifNil: [ PhLHTTPListingTemplateGroup defaultFilterPattern ].
					^ PhLHTTPListingTemplateGroup
						name: name
						url: url asZnUrl
						filterPattern: pattern username: username password: password].
	type == self class jenkinsServerType 
		ifTrue: [ ^ PhLJenkins2Server name: name url: url asZnUrl username: username password: password ].
	type == self class urlGroupType
		ifTrue: [ ^ PhLFixedURLsTemplateGroup new 
						setName: name Templates: OrderedCollection new;
						yourself ].
	type == self class cacheType 
		ifTrue: [ ^ PhLDownloadedTemplateGroup named: name ].
	type == self class httpGithubReleaseType
		ifTrue: [ | pattern |
					pattern := filterPattern ifNil: [ PhLGithubReleaseTemplateGroup defaultFilterPattern ].
					^ PhLGithubReleaseTemplateGroup
						name: name
						url: url asZnUrl
						filterPattern: pattern username: username password: password].
		
	self error: 'Group type not supported!'
]

{ #category : #converting }
PhLTemplateSource >> asTemplate [
	type == self class urlType ifTrue: [ 
		^ PhLRemoteTemplate
			  name: name
			  url: url asUrl
			  username: username
			  password: password ].
	self error: 'Template type not supported!'
]

{ #category : #converting }
PhLTemplateSource >> asTemplateGroup [
	^ self asBasicTemplateGroup 
		isHighlighted: expanded;
		yourself
]

{ #category : #accessing }
PhLTemplateSource >> expanded [
	^ expanded notNil & expanded
]

{ #category : #accessing }
PhLTemplateSource >> expanded: aBoolean [
	"when source is a group, tell if it should be expanded as default"
	expanded := aBoolean
]

{ #category : #accessing }
PhLTemplateSource >> filterPattern [
	^ filterPattern
]

{ #category : #accessing }
PhLTemplateSource >> filterPattern: aString [ 
	filterPattern := aString
]

{ #category : #accessing }
PhLTemplateSource >> name [
	^ name
]

{ #category : #accessing }
PhLTemplateSource >> name: aString [ 
	name := aString
]

{ #category : #accessing }
PhLTemplateSource >> password [
	^ password
]

{ #category : #accessing }
PhLTemplateSource >> password: anObject [
	password := anObject
]

{ #category : #printing }
PhLTemplateSource >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPut: $(;
		nextPutAll: name;
		nextPut: $)
]

{ #category : #accessing }
PhLTemplateSource >> templates [
	^ templates
]

{ #category : #accessing }
PhLTemplateSource >> templates: aListOfTemplates [
	templates := aListOfTemplates.
]

{ #category : #iterating }
PhLTemplateSource >> templatesDo: aBlockClosure [ 
	templates ifNotNil: [ templates do: aBlockClosure ]
]

{ #category : #accessing }
PhLTemplateSource >> type [
	^ type
]

{ #category : #accessing }
PhLTemplateSource >> type: aString [ 
	type := aString
]

{ #category : #accessing }
PhLTemplateSource >> url [
	^ url
]

{ #category : #accessing }
PhLTemplateSource >> url: aString [ 
	url := aString
]

{ #category : #accessing }
PhLTemplateSource >> username [
	^ username
]

{ #category : #accessing }
PhLTemplateSource >> username: anObject [
	username := anObject
]
