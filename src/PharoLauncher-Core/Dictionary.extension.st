Extension { #name : #Dictionary }

{ #category : #'*PharoLauncher-Core' }
Dictionary >> asPhLImage [
	"old metadata file format"

	^ PhLImage new
		privOriginTemplate: (self at: #template);
		yourself
]
