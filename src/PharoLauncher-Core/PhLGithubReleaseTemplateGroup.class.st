"
Represent a list of release images directy from the Github relases project page, naming them with the file name and release tag.
The format of the releases files are Pharo[0-9]*.zip.
"
Class {
	#name : #PhLGithubReleaseTemplateGroup,
	#superclass : #PhLHTTPListingTemplateGroup,
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #defaults }
PhLGithubReleaseTemplateGroup class >> defaultFilterPattern [
	"Returns the default filter pattern to files using the name format Pharo[0-9]*.zip
	The parenthesis here are important because this is what we want to extract for each match. The #subexpression must correspond to the index of this pair of parenthesis"
	^'href="([^"]*Pharo[0-9][^"]*.zip)"'
]

{ #category : #accessing }
PhLGithubReleaseTemplateGroup >> createTemplateFromHref: filePath addingTo: templates [
	| fileName urlFile |
	fileName := self formatFileName: filePath.
	urlFile := 'https://',(ZnUrl fromString: url asString )host ,'/', filePath.
	templates	 add: (PhLRemoteTemplate name: fileName url: urlFile)
]

{ #category : #accessing }
PhLGithubReleaseTemplateGroup >> formatFileName: aGithubPath [
	"Receives a path like '/pharo-ide/TelePharo/releases/download/v0.4.2/Pharo7.0-32bit-TelePharo.zip' and returns the name of image file like 'Pharo7.0-32bit-TelePharo (v0.4.2)'"
	| pathSegments fileName tagName| 
	pathSegments := (ZnUrl fromString: aGithubPath).
	fileName := (pathSegments segments at: 6) copyUpToLast: $..
	tagName := pathSegments	 segments at: 5.
	^ fileName,' (',tagName,')' 
]
