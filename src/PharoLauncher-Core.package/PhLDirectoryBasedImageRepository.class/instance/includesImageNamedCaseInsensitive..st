testing
includesImageNamedCaseInsensitive: anImageName
	"Windows OS doesnt care about case for folder names."
	| lowercaseImageName |
	lowercaseImageName := anImageName asLowercase.
	^ self images anySatisfy: [ :image | image name asLowercase = lowercaseImageName ]