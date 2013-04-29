as yet unclassified
open: anImageLauncherModel selectCategory: aString

	| gui |
	gui := ImageLauncherTabUI new.
	gui model: anImageLauncherModel .
	gui listElements: (gui model buildList: aString) asArray .
	^ gui buildWithSpec: #defaultSpec